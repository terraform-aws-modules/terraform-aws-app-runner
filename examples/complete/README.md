# Complete AWS App Runner Example

Configuration in this directory creates:

- AppRunner shared configurations for:
  - GitHub connection
  - Autoscaling configuration for a "min" and "max" examples
- A code based AppRunner service
  - Utilizes "min" autoscaling configuration created in shared configs
- An image based AppRunner service
  - Utilizes "mega" autoscaling configuration created in shared configs
  - Creates a VPC connector to the associated VPC private subnets
  - Creates an example runtime environment variable and secret

## Usage

To run this example you need to execute:

1. Fork [this repository](https://github.com/aws-containers/hello-app-runner) to the account/organization associated with the GitHub connection that will be created

2.
```bash
$ terraform init
$ terraform plan
$ terraform apply -var="repository_url=<URL_TO_FORKED_REPOSITORY>"
```

3. Once you have entered `yes` at the prompt, you will need to navigate to the AppRunner console -> GitHub connections -> Complete the handshake for the connection created by this example.

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_runner_code_base"></a> [app\_runner\_code\_base](#module\_app\_runner\_code\_base) | ../.. | n/a |
| <a name="module_app_runner_disabled"></a> [app\_runner\_disabled](#module\_app\_runner\_disabled) | ../.. | n/a |
| <a name="module_app_runner_image_base"></a> [app\_runner\_image\_base](#module\_app\_runner\_image\_base) | ../.. | n/a |
| <a name="module_app_runner_private"></a> [app\_runner\_private](#module\_app\_runner\_private) | ../.. | n/a |
| <a name="module_app_runner_shared_configs"></a> [app\_runner\_shared\_configs](#module\_app\_runner\_shared\_configs) | ../.. | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 5.0 |
| <a name="module_vpc_endpoints_security_group"></a> [vpc\_endpoints\_security\_group](#module\_vpc\_endpoints\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository_url"></a> [repository\_url](#input\_repository\_url) | Location of the repository that contains the source code. Repository must be located in same scope as the GitHub connection (user's profile or organization) | `string` | `"https://github.com/aws-containers/hello-app-runner"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_scaling_configurations"></a> [auto\_scaling\_configurations](#output\_auto\_scaling\_configurations) | Map of attribute maps for all autosclaing configurations created |
| <a name="output_code_base_access_iam_role_arn"></a> [code\_base\_access\_iam\_role\_arn](#output\_code\_base\_access\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_code_base_access_iam_role_name"></a> [code\_base\_access\_iam\_role\_name](#output\_code\_base\_access\_iam\_role\_name) | The name of the IAM role |
| <a name="output_code_base_access_iam_role_unique_id"></a> [code\_base\_access\_iam\_role\_unique\_id](#output\_code\_base\_access\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_code_base_custom_domain_association_certificate_validation_records"></a> [code\_base\_custom\_domain\_association\_certificate\_validation\_records](#output\_code\_base\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_code_base_custom_domain_association_dns_target"></a> [code\_base\_custom\_domain\_association\_dns\_target](#output\_code\_base\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_code_base_custom_domain_association_id"></a> [code\_base\_custom\_domain\_association\_id](#output\_code\_base\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_code_base_instance_iam_role_arn"></a> [code\_base\_instance\_iam\_role\_arn](#output\_code\_base\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_code_base_instance_iam_role_name"></a> [code\_base\_instance\_iam\_role\_name](#output\_code\_base\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_code_base_instance_iam_role_unique_id"></a> [code\_base\_instance\_iam\_role\_unique\_id](#output\_code\_base\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_code_base_observability_configuration_arn"></a> [code\_base\_observability\_configuration\_arn](#output\_code\_base\_observability\_configuration\_arn) | ARN of this observability configuration |
| <a name="output_code_base_observability_configuration_latest"></a> [code\_base\_observability\_configuration\_latest](#output\_code\_base\_observability\_configuration\_latest) | Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name` |
| <a name="output_code_base_observability_configuration_revision"></a> [code\_base\_observability\_configuration\_revision](#output\_code\_base\_observability\_configuration\_revision) | The revision of the observability configuration |
| <a name="output_code_base_observability_configuration_status"></a> [code\_base\_observability\_configuration\_status](#output\_code\_base\_observability\_configuration\_status) | The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_code_base_service_arn"></a> [code\_base\_service\_arn](#output\_code\_base\_service\_arn) | The Amazon Resource Name (ARN) of the service |
| <a name="output_code_base_service_id"></a> [code\_base\_service\_id](#output\_code\_base\_service\_id) | An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region |
| <a name="output_code_base_service_status"></a> [code\_base\_service\_status](#output\_code\_base\_service\_status) | The current state of the App Runner service |
| <a name="output_code_base_service_url"></a> [code\_base\_service\_url](#output\_code\_base\_service\_url) | A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application |
| <a name="output_code_base_vpc_connector_arn"></a> [code\_base\_vpc\_connector\_arn](#output\_code\_base\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_code_base_vpc_connector_revision"></a> [code\_base\_vpc\_connector\_revision](#output\_code\_base\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_code_base_vpc_connector_status"></a> [code\_base\_vpc\_connector\_status](#output\_code\_base\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
| <a name="output_code_base_vpc_ingress_connection_arn"></a> [code\_base\_vpc\_ingress\_connection\_arn](#output\_code\_base\_vpc\_ingress\_connection\_arn) | The Amazon Resource Name (ARN) of the VPC Ingress Connection |
| <a name="output_code_base_vpc_ingress_connection_domain_name"></a> [code\_base\_vpc\_ingress\_connection\_domain\_name](#output\_code\_base\_vpc\_ingress\_connection\_domain\_name) | The domain name associated with the VPC Ingress Connection resource |
| <a name="output_connections"></a> [connections](#output\_connections) | Map of attribute maps for all connections created |
| <a name="output_image_base_access_iam_role_arn"></a> [image\_base\_access\_iam\_role\_arn](#output\_image\_base\_access\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_image_base_access_iam_role_name"></a> [image\_base\_access\_iam\_role\_name](#output\_image\_base\_access\_iam\_role\_name) | The name of the IAM role |
| <a name="output_image_base_access_iam_role_unique_id"></a> [image\_base\_access\_iam\_role\_unique\_id](#output\_image\_base\_access\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_image_base_custom_domain_association_certificate_validation_records"></a> [image\_base\_custom\_domain\_association\_certificate\_validation\_records](#output\_image\_base\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_image_base_custom_domain_association_dns_target"></a> [image\_base\_custom\_domain\_association\_dns\_target](#output\_image\_base\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_image_base_custom_domain_association_id"></a> [image\_base\_custom\_domain\_association\_id](#output\_image\_base\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_image_base_instance_iam_role_arn"></a> [image\_base\_instance\_iam\_role\_arn](#output\_image\_base\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_image_base_instance_iam_role_name"></a> [image\_base\_instance\_iam\_role\_name](#output\_image\_base\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_image_base_instance_iam_role_unique_id"></a> [image\_base\_instance\_iam\_role\_unique\_id](#output\_image\_base\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_image_base_observability_configuration_arn"></a> [image\_base\_observability\_configuration\_arn](#output\_image\_base\_observability\_configuration\_arn) | ARN of this observability configuration |
| <a name="output_image_base_observability_configuration_latest"></a> [image\_base\_observability\_configuration\_latest](#output\_image\_base\_observability\_configuration\_latest) | Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name` |
| <a name="output_image_base_observability_configuration_revision"></a> [image\_base\_observability\_configuration\_revision](#output\_image\_base\_observability\_configuration\_revision) | The revision of the observability configuration |
| <a name="output_image_base_observability_configuration_status"></a> [image\_base\_observability\_configuration\_status](#output\_image\_base\_observability\_configuration\_status) | The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_image_base_service_arn"></a> [image\_base\_service\_arn](#output\_image\_base\_service\_arn) | The Amazon Resource Name (ARN) of the service |
| <a name="output_image_base_service_id"></a> [image\_base\_service\_id](#output\_image\_base\_service\_id) | An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region |
| <a name="output_image_base_service_status"></a> [image\_base\_service\_status](#output\_image\_base\_service\_status) | The current state of the App Runner service |
| <a name="output_image_base_service_url"></a> [image\_base\_service\_url](#output\_image\_base\_service\_url) | A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application |
| <a name="output_image_base_vpc_connector_arn"></a> [image\_base\_vpc\_connector\_arn](#output\_image\_base\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_image_base_vpc_connector_revision"></a> [image\_base\_vpc\_connector\_revision](#output\_image\_base\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_image_base_vpc_connector_status"></a> [image\_base\_vpc\_connector\_status](#output\_image\_base\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
| <a name="output_image_base_vpc_ingress_connection_arn"></a> [image\_base\_vpc\_ingress\_connection\_arn](#output\_image\_base\_vpc\_ingress\_connection\_arn) | The Amazon Resource Name (ARN) of the VPC Ingress Connection |
| <a name="output_image_base_vpc_ingress_connection_domain_name"></a> [image\_base\_vpc\_ingress\_connection\_domain\_name](#output\_image\_base\_vpc\_ingress\_connection\_domain\_name) | The domain name associated with the VPC Ingress Connection resource |
| <a name="output_private_access_iam_role_arn"></a> [private\_access\_iam\_role\_arn](#output\_private\_access\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_private_access_iam_role_name"></a> [private\_access\_iam\_role\_name](#output\_private\_access\_iam\_role\_name) | The name of the IAM role |
| <a name="output_private_access_iam_role_unique_id"></a> [private\_access\_iam\_role\_unique\_id](#output\_private\_access\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_private_custom_domain_association_certificate_validation_records"></a> [private\_custom\_domain\_association\_certificate\_validation\_records](#output\_private\_custom\_domain\_association\_certificate\_validation\_records) | A set of certificate CNAME records used for this domain name |
| <a name="output_private_custom_domain_association_dns_target"></a> [private\_custom\_domain\_association\_dns\_target](#output\_private\_custom\_domain\_association\_dns\_target) | The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform |
| <a name="output_private_custom_domain_association_id"></a> [private\_custom\_domain\_association\_id](#output\_private\_custom\_domain\_association\_id) | The `domain_name` and `service_arn` separated by a comma (`,`) |
| <a name="output_private_instance_iam_role_arn"></a> [private\_instance\_iam\_role\_arn](#output\_private\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_private_instance_iam_role_name"></a> [private\_instance\_iam\_role\_name](#output\_private\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_private_instance_iam_role_unique_id"></a> [private\_instance\_iam\_role\_unique\_id](#output\_private\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_private_observability_configuration_arn"></a> [private\_observability\_configuration\_arn](#output\_private\_observability\_configuration\_arn) | ARN of this observability configuration |
| <a name="output_private_observability_configuration_latest"></a> [private\_observability\_configuration\_latest](#output\_private\_observability\_configuration\_latest) | Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name` |
| <a name="output_private_observability_configuration_revision"></a> [private\_observability\_configuration\_revision](#output\_private\_observability\_configuration\_revision) | The revision of the observability configuration |
| <a name="output_private_observability_configuration_status"></a> [private\_observability\_configuration\_status](#output\_private\_observability\_configuration\_status) | The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion |
| <a name="output_private_service_arn"></a> [private\_service\_arn](#output\_private\_service\_arn) | The Amazon Resource Name (ARN) of the service |
| <a name="output_private_service_id"></a> [private\_service\_id](#output\_private\_service\_id) | An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region |
| <a name="output_private_service_status"></a> [private\_service\_status](#output\_private\_service\_status) | The current state of the App Runner service |
| <a name="output_private_service_url"></a> [private\_service\_url](#output\_private\_service\_url) | A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application |
| <a name="output_private_vpc_connector_arn"></a> [private\_vpc\_connector\_arn](#output\_private\_vpc\_connector\_arn) | The Amazon Resource Name (ARN) of VPC connector |
| <a name="output_private_vpc_connector_revision"></a> [private\_vpc\_connector\_revision](#output\_private\_vpc\_connector\_revision) | The revision of VPC connector. It's unique among all the active connectors ("Status": "ACTIVE") that share the same Name |
| <a name="output_private_vpc_connector_status"></a> [private\_vpc\_connector\_status](#output\_private\_vpc\_connector\_status) | The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted |
| <a name="output_private_vpc_ingress_connection_arn"></a> [private\_vpc\_ingress\_connection\_arn](#output\_private\_vpc\_ingress\_connection\_arn) | The Amazon Resource Name (ARN) of the VPC Ingress Connection |
| <a name="output_private_vpc_ingress_connection_domain_name"></a> [private\_vpc\_ingress\_connection\_domain\_name](#output\_private\_vpc\_ingress\_connection\_domain\_name) | The domain name associated with the VPC Ingress Connection resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-app-runner/blob/master/LICENSE).
