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
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_apprunner_vpc_connector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_connector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_max_concurrency"></a> [autoscaling\_max\_concurrency](#input\_autoscaling\_max\_concurrency) | The maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service | `number` | `null` | no |
| <a name="input_autoscaling_max_size"></a> [autoscaling\_max\_size](#input\_autoscaling\_max\_size) | The maximal number of instances that App Runner provisions for your service | `number` | `1` | no |
| <a name="input_autoscaling_min_size"></a> [autoscaling\_min\_size](#input\_autoscaling\_min\_size) | The minimal number of instances that App Runner provisions for your service | `number` | `1` | no |
| <a name="input_autoscaling_name"></a> [autoscaling\_name](#input\_autoscaling\_name) | The name of the auto scaling configuration | `string` | `""` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | The name of the connection | `string` | `""` | no |
| <a name="input_connection_provider_type"></a> [connection\_provider\_type](#input\_connection\_provider\_type) | The source repository provider. Valid values: `GITHUB` | `string` | `"GITHUB"` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_vpc_connector"></a> [create\_vpc\_connector](#input\_create\_vpc\_connector) | Determines whether a VPC Connector will be created | `bool` | `true` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | Determines whether an Auto Scaling Configuration will be created | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_connector_name"></a> [vpc\_connector\_name](#input\_vpc\_connector\_name) | The name of the VPC Connector | `string` | `""` | no |
| <a name="input_vpc_connector_security_groups"></a> [vpc\_connector\_security\_groups](#input\_vpc\_connector\_security\_groups) | The security groups to use for the VPC Connector | `list(string)` | `[]` | no |
| <a name="input_vpc_connector_subnets"></a> [vpc\_connector\_subnets](#input\_vpc\_connector\_subnets) | The subnets to use for the VPC Connector | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_arn"></a> [connection\_arn](#output\_connection\_arn) | The Amazon Resource Name (ARN) of the connection |
| <a name="output_connection_status"></a> [connection\_status](#output\_connection\_status) | The current state of the App Runner connection. When the state is `AVAILABLE`, you can use the connection to create an aws\_apprunner\_service resource |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_vpc_connector_revision"></a> [vpc\_connector\_revision](#output\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_vpc_connector_status"></a> [vpc\_connector\_status](#output\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-app-runner/blob/main/LICENSE).
