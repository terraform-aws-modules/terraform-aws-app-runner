# AWS App Runner Terraform module

Terraform module which creates AWS App Runner resources.

## Usage

See [`examples`](https://github.com/clowdhaus/terraform-aws-app-runner/tree/main/examples) directory for working examples to reference:

```hcl
module "app_runner" {
  source = "clowdhaus/app-runner/aws"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/clowdhaus/terraform-aws-app-runner/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/clowdhaus/terraform-aws-app-runner/tree/main/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

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
| [aws_iam_policy.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.access_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.instance_xray](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.access_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
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
| <a name="input_create_instance_iam_role"></a> [create\_instance\_iam\_role](#input\_create\_instance\_iam\_role) | Determines whether an IAM role is created or to use an existing IAM role | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created for the VPC connector | `bool` | `true` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Determines whether the service will be created | `bool` | `true` | no |
| <a name="input_create_vpc_connector"></a> [create\_vpc\_connector](#input\_create\_vpc\_connector) | Determines whether a VPC Connector will be created | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The custom domain endpoint to association. Specify a base domain e.g., `example.com` or a subdomain e.g., `subdomain.example.com` | `string` | `""` | no |
| <a name="input_enable_www_subdomain"></a> [enable\_www\_subdomain](#input\_enable\_www\_subdomain) | Whether to associate the subdomain with the App Runner service in addition to the base domain. Defaults to `true` | `bool` | `null` | no |
| <a name="input_encryption_configuration"></a> [encryption\_configuration](#input\_encryption\_configuration) | The encryption configuration for the service | `any` | `{}` | no |
| <a name="input_health_check_configuration"></a> [health\_check\_configuration](#input\_health\_check\_configuration) | The health check configuration for the service | `any` | `{}` | no |
| <a name="input_instance_configuration"></a> [instance\_configuration](#input\_instance\_configuration) | The instance configuration for the service | `any` | `{}` | no |
| <a name="input_instance_iam_role_description"></a> [instance\_iam\_role\_description](#input\_instance\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_instance_iam_role_name"></a> [instance\_iam\_role\_name](#input\_instance\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_instance_iam_role_path"></a> [instance\_iam\_role\_path](#input\_instance\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_instance_iam_role_permissions_boundary"></a> [instance\_iam\_role\_permissions\_boundary](#input\_instance\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_instance_iam_role_policies"></a> [instance\_iam\_role\_policies](#input\_instance\_iam\_role\_policies) | IAM policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_instance_iam_role_use_name_prefix"></a> [instance\_iam\_role\_use\_name\_prefix](#input\_instance\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name (`iam_role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_network_configuration"></a> [network\_configuration](#input\_network\_configuration) | The network configuration for the service | `any` | `{}` | no |
| <a name="input_observability_configuration"></a> [observability\_configuration](#input\_observability\_configuration) | The observability configuration for the service | `any` | `{}` | no |
| <a name="input_observability_configurations"></a> [observability\_configurations](#input\_observability\_configurations) | Map of observability configuration definitions to create | `any` | `{}` | no |
| <a name="input_private_ecr_arn"></a> [private\_ecr\_arn](#input\_private\_ecr\_arn) | The ARN of the private ECR repository that contains the service image to launch | `string` | `null` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description for the security group created | `string` | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | List of security group rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service | `string` | `""` | no |
| <a name="input_source_configuration"></a> [source\_configuration](#input\_source\_configuration) | The source configuration for the service | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_connector_name"></a> [vpc\_connector\_name](#input\_vpc\_connector\_name) | The name of the VPC Connector | `string` | `""` | no |
| <a name="input_vpc_connector_security_groups"></a> [vpc\_connector\_security\_groups](#input\_vpc\_connector\_security\_groups) | The security groups to use for the VPC Connector | `list(string)` | `[]` | no |
| <a name="input_vpc_connector_subnets"></a> [vpc\_connector\_subnets](#input\_vpc\_connector\_subnets) | The subnets to use for the VPC Connector | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the security will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_iam_role_arn"></a> [access\_iam\_role\_arn](#output\_access\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_access_iam_role_name"></a> [access\_iam\_role\_name](#output\_access\_iam\_role\_name) | The name of the IAM role |
| <a name="output_access_iam_role_unique_id"></a> [access\_iam\_role\_unique\_id](#output\_access\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_auto_scaling_configurations"></a> [auto\_scaling\_configurations](#output\_auto\_scaling\_configurations) | Map of attribute maps for all autosclaing configurations created |
| <a name="output_connections"></a> [connections](#output\_connections) | Map of attribute maps for all connections created |
| <a name="output_custom_domain_association_certificate_validation_records"></a> [custom\_domain\_association\_certificate\_validation\_records](#output\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_custom_domain_association_dns_target"></a> [custom\_domain\_association\_dns\_target](#output\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_custom_domain_association_id"></a> [custom\_domain\_association\_id](#output\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_instance_iam_role_arn"></a> [instance\_iam\_role\_arn](#output\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_instance_iam_role_name"></a> [instance\_iam\_role\_name](#output\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_instance_iam_role_unique_id"></a> [instance\_iam\_role\_unique\_id](#output\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_observability_configurations"></a> [observability\_configurations](#output\_observability\_configurations) | Map of attribute maps for all observability configurations created |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the VPC connector security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the VPC connector security group |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | The Amazon Resource Name (ARN) of the service |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The current state of the App Runner service |
| <a name="output_service_url"></a> [service\_url](#output\_service\_url) | A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_vpc_connector_revision"></a> [vpc\_connector\_revision](#output\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_vpc_connector_status"></a> [vpc\_connector\_status](#output\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-app-runner/blob/main/LICENSE).
