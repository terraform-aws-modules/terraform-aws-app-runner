################################################################################
# Service
################################################################################

resource "aws_apprunner_service" "this" {
  count = var.create ? 1 : 0

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
      instance_role_arn = try(health_check_configuration.value.instance_role_arn, null)
      memory            = try(instance_configuration.value.memory, null)
    }
  }

  dynamic "network_configuration" {
    for_each = length(var.network_configuration) > 0 ? [var.network_configuration] : []

    content {
      dynamic "egress_configuration" {
        for_each = try([network_configuration.value.egress_configuration], [])

        content {
          egress_type       = try(egress_configuration.value.egress_type, null)
          vpc_connector_arn = try(egress_configuration.value.egress_type, aws_apprunner_vpc_connector.this.arn, null)
        }
      }
    }
  }

  dynamic "observability_configuration" {
    for_each = length(var.observability_configuration) > 0 ? [var.observability_configuration] : []

    content {
      observability_configuration_arn = observability_configuration.value.observability_configuration_arn
      observability_enabled           = observability_configuration.value.observability_enabled
    }
  }

  service_name = var.service_name

  dynamic "source_configuration" {
    for_each = [var.source_configuration]

    content {
      dynamic "authentication_configuration" {
        for_each = try([source_configuration.value.authentication_configuration], [])

        content {
          access_role_arn = try(authentication_configuration.value.access_role_arn, null)
          connection_arn  = try(authentication_configuration.value.connection_arn, aws_apprunner_connection.this.arn, null)
        }
      }

      auto_deployments_enabled = try(var.auto_deployments_enabled, null)

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
            }

            configuration_source = code_configuration.value.configuration_source
          }
        }

        repository_url = code_repository.value.repository_url

        dynamic "source_code_version" {
          for_each = [code_repository.value.source_code_version]

          content {
            type  = source_code_version.value.type
            value = source_code_version.value.value
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
# VPC Connector
################################################################################

resource "aws_apprunner_vpc_connector" "this" {
  count = var.create && var.create_vpc_connector ? 1 : 0

  vpc_connector_name = try(coalesce(var.vpc_connector_name, var.service_name), "")
  subnets            = var.vpc_connector_subnets
  security_groups    = var.vpc_connector_security_groups

  tags = var.tags
}

################################################################################
# Connection
################################################################################

resource "aws_apprunner_connection" "this" {
  count = var.create && var.create_connection ? 1 : 0

  connection_name = try(coalesce(var.connection_name, var.service_name), "")
  provider_type   = var.connection_provider_type

  tags = var.tags
}

################################################################################
# Autoscaling
################################################################################

resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  count = var.create && var.enable_autoscaling ? 1 : 0

  auto_scaling_configuration_name = try(coalesce(var.autoscaling_name, var.service_name), "")

  max_concurrency = var.autoscaling_max_concurrency
  max_size        = var.autoscaling_max_size
  min_size        = var.autoscaling_min_size

  tags = var.tags
}
