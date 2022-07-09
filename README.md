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
| [aws_route53_record.cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_deployments_enabled"></a> [auto\_deployments\_enabled](#input\_auto\_deployments\_enabled) | Whether auto deployments are enabled for the service | `bool` | `false` | no |
| <a name="input_autoscaling_configuration_arn"></a> [autoscaling\_configuration\_arn](#input\_autoscaling\_configuration\_arn) | The ARN of an existing Auto Scaling Configuration | `string` | `null` | no |
| <a name="input_autoscaling_max_concurrency"></a> [autoscaling\_max\_concurrency](#input\_autoscaling\_max\_concurrency) | The maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service | `number` | `null` | no |
| <a name="input_autoscaling_max_size"></a> [autoscaling\_max\_size](#input\_autoscaling\_max\_size) | The maximal number of instances that App Runner provisions for your service | `number` | `1` | no |
| <a name="input_autoscaling_min_size"></a> [autoscaling\_min\_size](#input\_autoscaling\_min\_size) | The minimal number of instances that App Runner provisions for your service | `number` | `1` | no |
| <a name="input_autoscaling_name"></a> [autoscaling\_name](#input\_autoscaling\_name) | The name of the auto scaling configuration | `string` | `null` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | The name of the connection | `string` | `""` | no |
| <a name="input_connection_provider_type"></a> [connection\_provider\_type](#input\_connection\_provider\_type) | The source repository provider. Valid values: `GITHUB` | `string` | `"GITHUB"` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_autoscaling_configuration"></a> [create\_autoscaling\_configuration](#input\_create\_autoscaling\_configuration) | Determines whether an Auto Scaling Configuration will be created | `bool` | `true` | no |
| <a name="input_create_connection"></a> [create\_connection](#input\_create\_connection) | Determines whether a connection will be created | `bool` | `true` | no |
| <a name="input_create_custom_domain_association"></a> [create\_custom\_domain\_association](#input\_create\_custom\_domain\_association) | Determines whether a Custom Domain Association will be created | `bool` | `true` | no |
| <a name="input_create_vpc_connector"></a> [create\_vpc\_connector](#input\_create\_vpc\_connector) | Determines whether a VPC Connector will be created | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The custom domain endpoint to association. Specify a base domain e.g., `example.com` or a subdomain e.g., `subdomain.example.com` | `string` | `""` | no |
| <a name="input_enable_observability_configuration"></a> [enable\_observability\_configuration](#input\_enable\_observability\_configuration) | Determines whether an Observability Configuration will be created | `bool` | `true` | no |
| <a name="input_enable_www_subdomain"></a> [enable\_www\_subdomain](#input\_enable\_www\_subdomain) | Whether to associate the subdomain with the App Runner service in addition to the base domain. Defaults to `true` | `bool` | `null` | no |
| <a name="input_encryption_configuration"></a> [encryption\_configuration](#input\_encryption\_configuration) | The encryption configuration for the service | `any` | `{}` | no |
| <a name="input_health_check_configuration"></a> [health\_check\_configuration](#input\_health\_check\_configuration) | The health check configuration for the service | `any` | `{}` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The ID of the Route53 hosted zone that contains the domain for the `domain_name` | `string` | `""` | no |
| <a name="input_instance_configuration"></a> [instance\_configuration](#input\_instance\_configuration) | The instance configuration for the service | `any` | `{}` | no |
| <a name="input_network_configuration"></a> [network\_configuration](#input\_network\_configuration) | The network configuration for the service | `any` | `{}` | no |
| <a name="input_observability_configuration_name"></a> [observability\_configuration\_name](#input\_observability\_configuration\_name) | The name of the Observability Configuration | `string` | `""` | no |
| <a name="input_observability_trace_configuration"></a> [observability\_trace\_configuration](#input\_observability\_trace\_configuration) | The name of the Trace Configuration | `any` | `{}` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service | `string` | `""` | no |
| <a name="input_source_configuration"></a> [source\_configuration](#input\_source\_configuration) | The source configuration for the service | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_connector_name"></a> [vpc\_connector\_name](#input\_vpc\_connector\_name) | The name of the VPC Connector | `string` | `""` | no |
| <a name="input_vpc_connector_security_groups"></a> [vpc\_connector\_security\_groups](#input\_vpc\_connector\_security\_groups) | The security groups to use for the VPC Connector | `list(string)` | `[]` | no |
| <a name="input_vpc_connector_subnets"></a> [vpc\_connector\_subnets](#input\_vpc\_connector\_subnets) | The subnets to use for the VPC Connector | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_configuration_arn"></a> [autoscaling\_configuration\_arn](#output\_autoscaling\_configuration\_arn) | ARN of this auto scaling configuration version |
| <a name="output_autoscaling_configuration_latest"></a> [autoscaling\_configuration\_latest](#output\_autoscaling\_configuration\_latest) | Whether the auto scaling configuration has the highest `auto_scaling_configuration_revision` among all configurations that share the same `auto_scaling_configuration_name` |
| <a name="output_autoscaling_configuration_revision"></a> [autoscaling\_configuration\_revision](#output\_autoscaling\_configuration\_revision) | The revision of this auto scaling configuration |
| <a name="output_autoscaling_configuration_status"></a> [autoscaling\_configuration\_status](#output\_autoscaling\_configuration\_status) | The current state of the auto scaling configuration. An INACTIVE configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_connection_arn"></a> [connection\_arn](#output\_connection\_arn) | The Amazon Resource Name (ARN) of the connection |
| <a name="output_connection_status"></a> [connection\_status](#output\_connection\_status) | The current state of the App Runner connection. When the state is `AVAILABLE`, you can use the connection to create an aws\_apprunner\_service resource |
| <a name="output_custom_domain_association_certificate_validation_records"></a> [custom\_domain\_association\_certificate\_validation\_records](#output\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_custom_domain_association_dns_target"></a> [custom\_domain\_association\_dns\_target](#output\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_custom_domain_association_id"></a> [custom\_domain\_association\_id](#output\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_observability_configuration_arn"></a> [observability\_configuration\_arn](#output\_observability\_configuration\_arn) | ARN of this observability configuration |
| <a name="output_observability_configuration_latest"></a> [observability\_configuration\_latest](#output\_observability\_configuration\_latest) | Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name` |
| <a name="output_observability_configuration_revision"></a> [observability\_configuration\_revision](#output\_observability\_configuration\_revision) | The revision of the observability configuration |
| <a name="output_observability_configuration_status"></a> [observability\_configuration\_status](#output\_observability\_configuration\_status) | The current state of the observability configuration. An INACTIVE configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_vpc_connector_revision"></a> [vpc\_connector\_revision](#output\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_vpc_connector_status"></a> [vpc\_connector\_status](#output\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-app-runner/blob/main/LICENSE).
