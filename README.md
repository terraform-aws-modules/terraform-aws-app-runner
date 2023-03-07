# AWS App Runner Terraform module

Terraform module which creates AWS App Runner resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-app-runner/tree/master/examples) directory for working examples to reference:

### AppRunner Common/Shared Configurations

```hcl
module "app_runner_shared_configs" {
  source = "terraform-aws-modules/app-runner/aws"

  # Disable service resources
  create_service = false

  connections = {
    # The AWS Connector for GitHub connects to your GitHub account is a one-time setup,
    # You can reuse the connection for creating multiple App Runner services based on repositories in this account.
    # After creation, you must complete the authentication handshake using the App Runner console.
    github = {
      provider_type = "GITHUB"
    }
  }

  auto_scaling_configurations = {
    mini = {
      name            = "mini"
      max_concurrency = 20
      max_size        = 5
      min_size        = 1

      tags = {
        Type = "Mini"
      }
    }

    mega = {
      name            = "mega"
      max_concurrency = 200
      max_size        = 25
      min_size        = 5

      tags = {
        Type = "MEGA"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Code Based AppRunner Service

```hcl
module "app_runner_code_base" {
  source = "terraform-aws-modules/app-runner/aws"

  service_name = "example-code-base"

  # From shared configs created above
  auto_scaling_configuration_arn = module.app_runner_shared_configs.auto_scaling_configurations["mini"].arn

  source_configuration = {
    authentication_configuration = {
      # From shared configs created above
      connection_arn = module.app_runner_shared_configs.connections["github"].arn
    }
    auto_deployments_enabled = false
    code_repository = {
      code_configuration = {
        configuration_source = "REPOSITORY"
      }
      repository_url = "https://github.com/aws-containers/hello-app-runner"
      source_code_version = {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Image Based AppRunner Service

```hcl
module "app_runner_image_base" {
  source = "terraform-aws-modules/app-runner/aws"

  service_name = "example-image-base"

  # From shared configs
  auto_scaling_configuration_arn = module.app_runner_shared_configs.auto_scaling_configurations["mega"].arn

  # Creating IAM instance profile to access secrets
  create_instance_iam_role = true
  instance_iam_role_policies = {
    secrets_policy = aws_iam_policy.instance_policy.arn
  }

  source_configuration = {
    auto_deployments_enabled = false
    image_repository = {
      image_configuration = {
        port = 8000
        runtime_environment_variables = {
          MY_VARIABLE = "hello!"
        }
        runtime_environment_secrets = {
          MY_SECRET = aws_secretsmanager_secret.example_secret.arn
        }
      }
      image_identifier      = "public.ecr.aws/aws-containers/hello-app-runner:latest"
      image_repository_type = "ECR_PUBLIC"
    }
  }

  create_vpc_connector          = true
  vpc_connector_subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_connector_security_groups = ["sg-12345678"]
  network_configuration = {
    egress_configuration = {
      egress_type = "VPC"
    }
  }

  enable_observability_configuration = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### Private AppRunner Service

```hcl
module "app_runner_private" {
  source = "terraform-aws-modules/app-runner/aws"

  service_name = "example-private"

  ...

  # Ingress
  create_ingress_vpc_connection = true
  ingress_vpc_id                = "vpc-12345678"
  ingress_vpc_endpoint_id       = "vpce-01234567890123456 s"

  # Egress
  create_vpc_connector          = true
  vpc_connector_subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_connector_security_groups = ["sg-12345678"]

  network_configuration = {
    ingress_configuration = {
      is_publicly_accessible = false
    }
    egress_configuration = {
      egress_type = "VPC"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-app-runner/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-app-runner/tree/master/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.51 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.51 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apprunner_auto_scaling_configuration_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_auto_scaling_configuration_version) | resource |
| [aws_apprunner_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_connection) | resource |
| [aws_apprunner_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_custom_domain_association) | resource |
| [aws_apprunner_observability_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_observability_configuration) | resource |
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_apprunner_vpc_connector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_connector) | resource |
| [aws_apprunner_vpc_ingress_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_ingress_connection) | resource |
| [aws_iam_policy.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.access_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.instance_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.instance_xray](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.access_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.instance_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_iam_role_description"></a> [access\_iam\_role\_description](#input\_access\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_access_iam_role_name"></a> [access\_iam\_role\_name](#input\_access\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_access_iam_role_path"></a> [access\_iam\_role\_path](#input\_access\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_access_iam_role_permissions_boundary"></a> [access\_iam\_role\_permissions\_boundary](#input\_access\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_access_iam_role_policies"></a> [access\_iam\_role\_policies](#input\_access\_iam\_role\_policies) | IAM policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_access_iam_role_use_name_prefix"></a> [access\_iam\_role\_use\_name\_prefix](#input\_access\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name (`iam_role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_auto_scaling_configuration_arn"></a> [auto\_scaling\_configuration\_arn](#input\_auto\_scaling\_configuration\_arn) | ARN of an App Runner automatic scaling configuration resource that you want to associate with your service. If not provided, App Runner associates the latest revision of a default auto scaling configuration | `string` | `null` | no |
| <a name="input_auto_scaling_configurations"></a> [auto\_scaling\_configurations](#input\_auto\_scaling\_configurations) | Map of auto-scaling configuration definitions to create | `any` | `{}` | no |
| <a name="input_connections"></a> [connections](#input\_connections) | Map of connection definitions to create | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_access_iam_role"></a> [create\_access\_iam\_role](#input\_create\_access\_iam\_role) | Determines whether an IAM role is created or to use an existing IAM role | `bool` | `false` | no |
| <a name="input_create_custom_domain_association"></a> [create\_custom\_domain\_association](#input\_create\_custom\_domain\_association) | Determines whether a Custom Domain Association will be created | `bool` | `false` | no |
| <a name="input_create_ingress_vpc_connection"></a> [create\_ingress\_vpc\_connection](#input\_create\_ingress\_vpc\_connection) | Determines whether a VPC ingress configuration will be created | `bool` | `false` | no |
| <a name="input_create_instance_iam_role"></a> [create\_instance\_iam\_role](#input\_create\_instance\_iam\_role) | Determines whether an IAM role is created or to use an existing IAM role | `bool` | `true` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Determines whether the service will be created | `bool` | `true` | no |
| <a name="input_create_vpc_connector"></a> [create\_vpc\_connector](#input\_create\_vpc\_connector) | Determines whether a VPC Connector will be created | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The custom domain endpoint to association. Specify a base domain e.g., `example.com` or a subdomain e.g., `subdomain.example.com` | `string` | `""` | no |
| <a name="input_enable_observability_configuration"></a> [enable\_observability\_configuration](#input\_enable\_observability\_configuration) | Determines whether an X-Ray Observability Configuration will be created and assigned to the service | `bool` | `true` | no |
| <a name="input_enable_www_subdomain"></a> [enable\_www\_subdomain](#input\_enable\_www\_subdomain) | Whether to associate the subdomain with the App Runner service in addition to the base domain. Defaults to `true` | `bool` | `null` | no |
| <a name="input_encryption_configuration"></a> [encryption\_configuration](#input\_encryption\_configuration) | The encryption configuration for the service | `any` | `{}` | no |
| <a name="input_health_check_configuration"></a> [health\_check\_configuration](#input\_health\_check\_configuration) | The health check configuration for the service | `any` | `{}` | no |
| <a name="input_ingress_vpc_endpoint_id"></a> [ingress\_vpc\_endpoint\_id](#input\_ingress\_vpc\_endpoint\_id) | The ID of the VPC endpoint that is used for the VPC ingress configuration | `string` | `""` | no |
| <a name="input_ingress_vpc_id"></a> [ingress\_vpc\_id](#input\_ingress\_vpc\_id) | The ID of the VPC that is used for the VPC ingress configuration | `string` | `""` | no |
| <a name="input_instance_configuration"></a> [instance\_configuration](#input\_instance\_configuration) | The instance configuration for the service | `any` | `{}` | no |
| <a name="input_instance_iam_role_description"></a> [instance\_iam\_role\_description](#input\_instance\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_instance_iam_role_name"></a> [instance\_iam\_role\_name](#input\_instance\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_instance_iam_role_path"></a> [instance\_iam\_role\_path](#input\_instance\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_instance_iam_role_permissions_boundary"></a> [instance\_iam\_role\_permissions\_boundary](#input\_instance\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_instance_iam_role_policies"></a> [instance\_iam\_role\_policies](#input\_instance\_iam\_role\_policies) | IAM policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_instance_iam_role_use_name_prefix"></a> [instance\_iam\_role\_use\_name\_prefix](#input\_instance\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name (`iam_role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_instance_policy_statements"></a> [instance\_policy\_statements](#input\_instance\_policy\_statements) | A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage | `any` | `{}` | no |
| <a name="input_network_configuration"></a> [network\_configuration](#input\_network\_configuration) | The network configuration for the service | `any` | `{}` | no |
| <a name="input_observability_configuration"></a> [observability\_configuration](#input\_observability\_configuration) | The observability configuration for the service | `any` | `{}` | no |
| <a name="input_private_ecr_arn"></a> [private\_ecr\_arn](#input\_private\_ecr\_arn) | The ARN of the private ECR repository that contains the service image to launch | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service | `string` | `""` | no |
| <a name="input_source_configuration"></a> [source\_configuration](#input\_source\_configuration) | The source configuration for the service | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_connector_name"></a> [vpc\_connector\_name](#input\_vpc\_connector\_name) | The name of the VPC Connector | `string` | `""` | no |
| <a name="input_vpc_connector_security_groups"></a> [vpc\_connector\_security\_groups](#input\_vpc\_connector\_security\_groups) | The security groups to use for the VPC Connector | `list(string)` | `[]` | no |
| <a name="input_vpc_connector_subnets"></a> [vpc\_connector\_subnets](#input\_vpc\_connector\_subnets) | The subnets to use for the VPC Connector | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_iam_role_arn"></a> [access\_iam\_role\_arn](#output\_access\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_access_iam_role_name"></a> [access\_iam\_role\_name](#output\_access\_iam\_role\_name) | The name of the IAM role |
| <a name="output_access_iam_role_unique_id"></a> [access\_iam\_role\_unique\_id](#output\_access\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_auto_scaling_configurations"></a> [auto\_scaling\_configurations](#output\_auto\_scaling\_configurations) | Map of attribute maps for all autoscaling configurations created |
| <a name="output_connections"></a> [connections](#output\_connections) | Map of attribute maps for all connections created |
| <a name="output_custom_domain_association_certificate_validation_records"></a> [custom\_domain\_association\_certificate\_validation\_records](#output\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_custom_domain_association_dns_target"></a> [custom\_domain\_association\_dns\_target](#output\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_custom_domain_association_id"></a> [custom\_domain\_association\_id](#output\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_instance_iam_role_arn"></a> [instance\_iam\_role\_arn](#output\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_instance_iam_role_name"></a> [instance\_iam\_role\_name](#output\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_instance_iam_role_unique_id"></a> [instance\_iam\_role\_unique\_id](#output\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_observability_configuration_arn"></a> [observability\_configuration\_arn](#output\_observability\_configuration\_arn) | ARN of this observability configuration |
| <a name="output_observability_configuration_latest"></a> [observability\_configuration\_latest](#output\_observability\_configuration\_latest) | Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name` |
| <a name="output_observability_configuration_revision"></a> [observability\_configuration\_revision](#output\_observability\_configuration\_revision) | The revision of the observability configuration |
| <a name="output_observability_configuration_status"></a> [observability\_configuration\_status](#output\_observability\_configuration\_status) | The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The Amazon Resource Name (ARN) of the service |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The current state of the App Runner service |
| <a name="output_service_url"></a> [service\_url](#output\_service\_url) | A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_vpc_connector_revision"></a> [vpc\_connector\_revision](#output\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_vpc_connector_status"></a> [vpc\_connector\_status](#output\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
| <a name="output_vpc_ingress_connection_arn"></a> [vpc\_ingress\_connection\_arn](#output\_vpc\_ingress\_connection\_arn) | The Amazon Resource Name (ARN) of the VPC Ingress Connection |
| <a name="output_vpc_ingress_connection_domain_name"></a> [vpc\_ingress\_connection\_domain\_name](#output\_vpc\_ingress\_connection\_domain\_name) | The domain name associated with the VPC Ingress Connection resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-app-runner/blob/master/LICENSE).
