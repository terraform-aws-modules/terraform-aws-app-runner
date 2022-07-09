################################################################################
# Service
################################################################################

output "service_arn" {
  description = "The Amazon Resource Name (ARN) of the service"
  value       = module.app_runner.service_arn
}

output "service_id" {
  description = "An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region"
  value       = module.app_runner.service_id
}

output "service_url" {
  description = "A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application"
  value       = module.app_runner.service_id
}

output "service_status" {
  description = "The current state of the App Runner service"
  value       = module.app_runner.service_status
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.app_runner.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.app_runner.cloudwatch_log_group_arn
}

################################################################################
# IAM Role - Access
################################################################################

output "access_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner.access_iam_role_name
}

output "access_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner.access_iam_role_arn
}

output "access_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner.access_iam_role_unique_id
}

################################################################################
# IAM Role - Instance
################################################################################

output "instance_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.app_runner.instance_iam_role_name
}

output "instance_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.app_runner.instance_iam_role_arn
}

output "instance_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.app_runner.instance_iam_role_unique_id
}

################################################################################
# VPC Connector
################################################################################

output "vpc_connector_arn" {
  description = "The Amazon Resource Name (ARN) of VPC connector"
  value       = module.app_runner.vpc_connector_arn
}

output "vpc_connector_status" {
  description = "The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted"
  value       = module.app_runner.vpc_connector_status
}

output "vpc_connector_revision" {
  description = "The revision of VPC connector. It's unique among all the active connectors (\"Status\": \"ACTIVE\") that share the same Name"
  value       = module.app_runner.vpc_connector_revision
}

################################################################################
# Autoscaling
################################################################################

output "autoscaling_configuration_arn" {
  description = "ARN of this auto scaling configuration version"
  value       = module.app_runner.autoscaling_configuration_arn
}

output "autoscaling_configuration_revision" {
  description = "The revision of this auto scaling configuration"
  value       = module.app_runner.autoscaling_configuration_revision
}

output "autoscaling_configuration_latest" {
  description = "Whether the auto scaling configuration has the highest `auto_scaling_configuration_revision` among all configurations that share the same `auto_scaling_configuration_name`"
  value       = module.app_runner.autoscaling_configuration_latest
}

output "autoscaling_configuration_status" {
  description = "The current state of the auto scaling configuration. An INACTIVE configuration revision has been deleted and can't be used. It is permanently removed some time after deletion"
  value       = module.app_runner.autoscaling_configuration_status
}

################################################################################
# Custom Domain Association
################################################################################

output "custom_domain_association_id" {
  description = "The `domain_name` and `service_arn` separated by a comma (`,`)"
  value       = module.app_runner.custom_domain_association_id
}

output "custom_domain_association_certificate_validation_records" {
  description = "A set of certificate CNAME records used for this domain name"
  value       = module.app_runner.custom_domain_association_certificate_validation_records
}

output "custom_domain_association_dns_target" {
  description = "The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform"
  value       = module.app_runner.custom_domain_association_dns_target
}

################################################################################
# Observability Configuration
################################################################################

output "observability_configuration_arn" {
  description = "ARN of this observability configuration"
  value       = module.app_runner.observability_configuration_arn
}

output "observability_configuration_revision" {
  description = "The revision of the observability configuration"
  value       = module.app_runner.observability_configuration_revision
}

output "observability_configuration_latest" {
  description = "Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name`"
  value       = module.app_runner.observability_configuration_latest
}

output "observability_configuration_status" {
  description = "The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion"
  value       = module.app_runner.observability_configuration_status
}
