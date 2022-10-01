data "aws_partition" "current" {}

################################################################################
# Service
################################################################################

resource "aws_apprunner_service" "this" {
  count = var.create && var.create_service ? 1 : 0

  auto_scaling_configuration_arn = var.auto_scaling_configuration_arn

  dynamic "encryption_configuration" {
    for_each = length(var.encryption_configuration) > 0 ? [var.encryption_configuration] : []

    content {
      kms_key = encryption_configuration.value.kms_key
    }
  }

  dynamic "health_check_configuration" {
    for_each = length(var.health_check_configuration) > 0 ? [var.health_check_configuration] : []

    content {
      healthy_threshold   = try(health_check_configuration.value.healthy_threshold, null)
      interval            = try(health_check_configuration.value.interval, null)
      path                = try(health_check_configuration.value.path, null)
      protocol            = try(health_check_configuration.value.protocol, null)
      timeout             = try(health_check_configuration.value.timeout, null)
      unhealthy_threshold = try(health_check_configuration.value.unhealthy_threshold, null)
    }
  }

  dynamic "instance_configuration" {
    for_each = length(var.instance_configuration) > 0 ? [var.instance_configuration] : []

    content {
      cpu               = try(instance_configuration.value.cpu, null)
      instance_role_arn = var.create_instance_iam_role ? aws_iam_role.instance[0].arn : try(instance_configuration.value.instance_role_arn, null)
      memory            = try(instance_configuration.value.memory, null)
    }
  }

  dynamic "network_configuration" {
    for_each = length(var.network_configuration) > 0 ? [var.network_configuration] : []

    content {
      dynamic "egress_configuration" {
        for_each = try([network_configuration.value.egress_configuration], [])

        content {
          egress_type       = try(egress_configuration.value.egress_type, "VPC")
          vpc_connector_arn = try(egress_configuration.value.vpc_connector_arn, aws_apprunner_vpc_connector.this[0].arn, null)
        }
      }
    }
  }

  dynamic "observability_configuration" {
    for_each = local.enable_observability_configuration ? [1] : []

    content {
      observability_configuration_arn = aws_apprunner_observability_configuration.this[0].arn
      observability_enabled           = true
    }
  }

  service_name = var.service_name


  dynamic "source_configuration" {
    for_each = [var.source_configuration]

    content {
      dynamic "authentication_configuration" {
        for_each = try([source_configuration.value.authentication_configuration], [])

        content {
          access_role_arn = var.create_access_iam_role ? aws_iam_role.access[0].arn : try(authentication_configuration.value.access_role_arn, null)
          connection_arn  = try(authentication_configuration.value.connection_arn, null)
        }
      }

      # Must be false when using public images or cross account images
      auto_deployments_enabled = try(source_configuration.value.auto_deployments_enabled, false)

      dynamic "code_repository" {
        for_each = try([source_configuration.value.code_repository], [])

        content {
          dynamic "code_configuration" {
            for_each = try([code_repository.value.code_configuration], [])

            content {
              dynamic "code_configuration_values" {
                for_each = try([code_configuration.value.code_configuration_values], [])

                content {
                  build_command                 = try(code_configuration_values.value.build_command, null)
                  port                          = try(code_configuration_values.value.port, null)
                  runtime                       = code_configuration_values.value.runtime
                  runtime_environment_variables = try(code_configuration_values.value.runtime_environment_variables, {})
                  start_command                 = try(code_configuration_values.value.start_command, null)
                }
              }

              configuration_source = code_configuration.value.configuration_source
            }
          }

          repository_url = code_repository.value.repository_url

          dynamic "source_code_version" {
            for_each = [code_repository.value.source_code_version]

            content {
              type  = try(source_code_version.value.type, "BRANCH")
              value = source_code_version.value.value
            }
          }
        }
      }

      dynamic "image_repository" {
        for_each = try([source_configuration.value.image_repository], [])

        content {
          dynamic "image_configuration" {
            for_each = try([image_repository.value.image_configuration], [])

            content {
              port                          = try(image_configuration.value.port, null)
              runtime_environment_variables = try(image_configuration.value.runtime_environment_variables, {})
              start_command                 = try(image_configuration.value.start_command, null)
            }
          }

          image_identifier      = image_repository.value.image_identifier
          image_repository_type = image_repository.value.image_repository_type
        }
      }
    }
  }

  tags = var.tags
}

################################################################################
# IAM Role - Access
################################################################################

locals {
  create_access_iam_role = var.create && var.create_service && var.create_access_iam_role

  access_iam_role_name = try(coalesce(var.access_iam_role_name, "${var.service_name}-access"), "")
}

data "aws_iam_policy_document" "access_assume_role" {
  count = local.create_access_iam_role ? 1 : 0

  statement {
    sid     = "AccessAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["build.apprunner.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "access" {
  count = local.create_access_iam_role ? 1 : 0

  name        = var.access_iam_role_use_name_prefix ? null : local.access_iam_role_name
  name_prefix = var.access_iam_role_use_name_prefix ? "${local.access_iam_role_name}-" : null
  path        = var.access_iam_role_path
  description = var.access_iam_role_description

  assume_role_policy    = data.aws_iam_policy_document.access_assume_role[0].json
  permissions_boundary  = var.access_iam_role_permissions_boundary
  force_detach_policies = true

  tags = var.tags
}

data "aws_iam_policy_document" "access" {
  count = local.create_access_iam_role && var.private_ecr_arn != null ? 1 : 0

  dynamic "statement" {
    for_each = var.private_ecr_arn != null ? [1] : []

    content {
      sid = "ReadPrivateEcr"
      actions = [
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:GetDownloadUrlForLayer",
      ]
      resources = [var.private_ecr_arn]
    }
  }

  dynamic "statement" {
    for_each = var.private_ecr_arn != null ? [1] : []

    content {
      sid = "AuthPrivateEcr"
      actions = [
        "ecr:DescribeImages",
        "ecr:GetAuthorizationToken",
      ]
      resources = ["*"]
    }
  }
}

resource "aws_iam_policy" "access" {
  count = local.create_access_iam_role && var.private_ecr_arn != null ? 1 : 0

  name        = var.access_iam_role_use_name_prefix ? null : local.access_iam_role_name
  name_prefix = var.access_iam_role_use_name_prefix ? "${local.access_iam_role_name}-" : null
  path        = var.access_iam_role_path
  description = var.access_iam_role_description

  policy = data.aws_iam_policy_document.access[0].json
}

resource "aws_iam_role_policy_attachment" "access" {
  count = local.create_access_iam_role && var.private_ecr_arn != null ? 1 : 0

  policy_arn = aws_iam_policy.access[0].arn
  role       = aws_iam_role.access[0].name
}

resource "aws_iam_role_policy_attachment" "access_additional" {
  for_each = { for k, v in var.access_iam_role_policies : k => v if local.create_access_iam_role }

  policy_arn = each.value
  role       = aws_iam_role.access[0].name
}

################################################################################
# IAM Role - Instance
################################################################################

locals {
  create_instance_iam_role = var.create && var.create_service && var.create_instance_iam_role

  instance_iam_role_name = try(coalesce(var.instance_iam_role_name, "${var.service_name}-instance"), "")
}

data "aws_iam_policy_document" "instance_assume_role" {
  count = var.create && var.create_instance_iam_role ? 1 : 0

  statement {
    sid     = "InstanceAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["tasks.apprunner.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "instance" {
  count = local.create_instance_iam_role ? 1 : 0

  name        = var.instance_iam_role_use_name_prefix ? null : local.instance_iam_role_name
  name_prefix = var.instance_iam_role_use_name_prefix ? "${local.instance_iam_role_name}-" : null
  path        = var.instance_iam_role_path
  description = var.instance_iam_role_description

  assume_role_policy    = data.aws_iam_policy_document.instance_assume_role[0].json
  permissions_boundary  = var.instance_iam_role_permissions_boundary
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "instance_xray" {
  count = local.create_instance_iam_role && try(var.observability_configuration.value.observability_enabled, false) ? 1 : 0

  policy_arn = "arn:${data.aws_partition.current.id}:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = aws_iam_role.instance[0].name
}

resource "aws_iam_role_policy_attachment" "instance" {
  for_each = { for k, v in var.instance_iam_role_policies : k => v if local.create_instance_iam_role }

  policy_arn = each.value
  role       = aws_iam_role.instance[0].name
}

################################################################################
# Custom Domain Association
################################################################################

locals {
  create_custom_domain_association = var.create && var.create_service && var.create_custom_domain_association
}

resource "aws_apprunner_custom_domain_association" "this" {
  count = local.create_custom_domain_association ? 1 : 0

  domain_name          = var.domain_name
  enable_www_subdomain = var.enable_www_subdomain
  service_arn          = aws_apprunner_service.this[0].arn
}

# # Requires manual intervention to validate records
# resource "aws_route53_record" "validation" {
#   count = length(aws_apprunner_custom_domain_association.this[0].certificate_validation_records)

#   allow_overwrite = true
#   name            = aws_apprunner_custom_domain_association.this[0].certificate_validation_records.*.name[count.index]
#   records         = [aws_apprunner_custom_domain_association.this[0].certificate_validation_records.*.value[count.index]]
#   ttl             = 60
#   type            = aws_apprunner_custom_domain_association.this[0].certificate_validation_records.*.type[count.index]
#   zone_id         = var.hosted_zone_id
# }

# resource "aws_route53_record" "validation" {
#   for_each = {
#     for dvo in aws_apprunner_custom_domain_association.this[0].certificate_validation_records : dvo.name => {
#       name   = dvo.name
#       record = dvo.value
#       type   = dvo.type
#     } if local.create_custom_domain_association
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = var.hosted_zone_id
# }

# resource "aws_route53_record" "cname" {
#   count = local.create_custom_domain_association && var.domain_name_use_cname ? 1 : 0

#   allow_overwrite = true
#   name            = var.domain_name
#   records         = [aws_apprunner_custom_domain_association.this[0].dns_target]
#   ttl             = 3600
#   type            = "CNAME"
#   zone_id         = var.hosted_zone_id
# }

# resource "aws_route53_record" "alias" {
#   for_each = { for k, v in toset(["A", "AAAA"]) : k => v if local.create_custom_domain_association && var.domain_name_use_cname }

#   zone_id = var.hosted_zone_id
#   name    = var.domain_name
#   type    = each.value

#   alias {
#     name                   = aws_apprunner_service.this[0].service_url
#     zone_id                = <TODO> ???
#     evaluate_target_health = true
#   }
# }

################################################################################
# VPC Connector
################################################################################

locals {
  create_vpc_connector = var.create && var.create_service && var.create_vpc_connector

  vpc_connector_name = try(coalesce(var.vpc_connector_name, var.service_name), "")
}

resource "aws_apprunner_vpc_connector" "this" {
  count = local.create_vpc_connector ? 1 : 0

  vpc_connector_name = local.vpc_connector_name
  subnets            = var.vpc_connector_subnets
  security_groups    = var.vpc_connector_security_groups

  tags = var.tags
}

################################################################################
# Connection(s)
################################################################################

resource "aws_apprunner_connection" "this" {
  for_each = { for k, v in var.connections : k => v if var.create }

  connection_name = try(each.value.name, each.key)
  provider_type   = try(each.value.provider_type, "GITHUB")

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# Auto-Scaling Configuration(s)
################################################################################

resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  for_each = { for k, v in var.auto_scaling_configurations : k => v if var.create }

  auto_scaling_configuration_name = try(each.value.name, each.key)
  max_concurrency                 = try(each.value.max_concurrency, null)
  max_size                        = try(each.value.max_size, null)
  min_size                        = try(each.value.min_size, null)

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# Observability Configuration(s)
################################################################################

locals {
  enable_observability_configuration = var.create && var.create_service && var.enable_observability_configuration
}

resource "aws_apprunner_observability_configuration" "this" {
  count = local.enable_observability_configuration ? 1 : 0

  observability_configuration_name = var.service_name

  trace_configuration {
    vendor = "AWSXRAY"
  }

  tags = var.tags
}
