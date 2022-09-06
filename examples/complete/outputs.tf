################################################################################
# Shared Configurations
################################################################################

output "connections" {
  description = "Map of attribute maps for all connections created"
  value       = module.app_runner_shared_configs.connections
}

output "auto_scaling_configurations" {
  description = "Map of attribute maps for all autosclaing configurations created"
  value       = module.app_runner_shared_configs.auto_scaling_configurations
}

################################################################################
# Code Base
################################################################################

output "code_base_service_arn" {
  description = "The Amazon Resource Name (ARN) of the service"
  value       = module.app_runner_code_base.service_arn
}

output "code_base_service_id" {
  description = "An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region"
  value       = module.app_runner_code_base.service_id
}

output "code_base_service_url" {
  description = "A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application"
  value       = module.app_runner_code_base.service_url
}

output "code_base_service_status" {
  description = "The current state of the App Runner service"
  value       = module.app_runner_code_base.service_status
}

output "code_base_access_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner_code_base.access_iam_role_name
}

output "code_base_access_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner_code_base.access_iam_role_arn
}

output "code_base_access_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner_code_base.access_iam_role_unique_id
}

output "code_base_instance_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner_code_base.instance_iam_role_name
}

output "code_base_instance_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner_code_base.instance_iam_role_arn
}

output "code_base_instance_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner_code_base.instance_iam_role_unique_id
}

output "code_base_custom_domain_association_id" {
  description = "The `domain_name` and `service_arn` separated by a comma (`,`)"
  value       = module.app_runner_code_base.custom_domain_association_id
}

output "code_base_custom_domain_association_certificate_validation_records" {
  description = "A set of certificate CNAME records used for this domain name"
  value       = module.app_runner_code_base.custom_domain_association_certificate_validation_records
}

output "code_base_custom_domain_association_dns_target" {
  description = "The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform"
  value       = module.app_runner_code_base.custom_domain_association_dns_target
}

output "code_base_vpc_connector_arn" {
  description = "The Amazon Resource Name (ARN) of VPC connector"
  value       = module.app_runner_code_base.vpc_connector_arn
}

output "code_base_vpc_connector_status" {
  description = "The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted"
  value       = module.app_runner_code_base.vpc_connector_status
}

output "code_base_vpc_connector_revision" {
  description = "The revision of VPC connector. It's unique among all the active connectors (\"Status\": \"ACTIVE\") that share the same Name"
  value       = module.app_runner_code_base.vpc_connector_revision
}

output "code_base_observability_configuration_arn" {
  description = "ARN of this observability configuration"
  value       = module.app_runner_code_base.observability_configuration_arn
}

output "code_base_observability_configuration_revision" {
  description = "The revision of the observability configuration"
  value       = module.app_runner_code_base.observability_configuration_revision
}

output "code_base_observability_configuration_latest" {
  description = "Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name`"
  value       = module.app_runner_code_base.observability_configuration_latest
}

output "code_base_observability_configuration_status" {
  description = "The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion"
  value       = module.app_runner_code_base.observability_configuration_status
}

################################################################################
# Image Base
################################################################################

output "image_base_service_arn" {
  description = "The Amazon Resource Name (ARN) of the service"
  value       = module.app_runner_image_base.service_arn
}

output "image_base_service_id" {
  description = "An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region"
  value       = module.app_runner_image_base.service_id
}

output "image_base_service_url" {
  description = "A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application"
  value       = module.app_runner_image_base.service_url
}

output "image_base_service_status" {
  description = "The current state of the App Runner service"
  value       = module.app_runner_image_base.service_status
}

output "image_base_access_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner_image_base.access_iam_role_name
}

output "image_base_access_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner_image_base.access_iam_role_arn
}

output "image_base_access_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner_image_base.access_iam_role_unique_id
}

output "image_base_instance_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner_image_base.instance_iam_role_name
}

output "image_base_instance_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner_image_base.instance_iam_role_arn
}

output "image_base_instance_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner_image_base.instance_iam_role_unique_id
}

output "image_base_custom_domain_association_id" {
  description = "The `domain_name` and `service_arn` separated by a comma (`,`)"
  value       = module.app_runner_image_base.custom_domain_association_id
}

output "image_base_custom_domain_association_certificate_validation_records" {
  description = "A set of certificate CNAME records used for this domain name"
  value       = module.app_runner_image_base.custom_domain_association_certificate_validation_records
}

output "image_base_custom_domain_association_dns_target" {
  description = "The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform"
  value       = module.app_runner_image_base.custom_domain_association_dns_target
}

output "image_base_vpc_connector_arn" {
  description = "The Amazon Resource Name (ARN) of VPC connector"
  value       = module.app_runner_image_base.vpc_connector_arn
}

output "image_base_vpc_connector_status" {
  description = "The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted"
  value       = module.app_runner_image_base.vpc_connector_status
}

output "image_base_vpc_connector_revision" {
  description = "The revision of VPC connector. It's unique among all the active connectors (\"Status\": \"ACTIVE\") that share the same Name"
  value       = module.app_runner_image_base.vpc_connector_revision
}

output "image_base_observability_configuration_arn" {
  description = "ARN of this observability configuration"
  value       = module.app_runner_image_base.observability_configuration_arn
}

output "image_base_observability_configuration_revision" {
  description = "The revision of the observability configuration"
  value       = module.app_runner_image_base.observability_configuration_revision
}

output "image_base_observability_configuration_latest" {
  description = "Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name`"
  value       = module.app_runner_image_base.observability_configuration_latest
}

output "image_base_observability_configuration_status" {
  description = "The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion"
  value       = module.app_runner_image_base.observability_configuration_status
}
