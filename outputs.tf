################################################################################
# Service
################################################################################

output "service_arn" {
  description = "The Amazon Resource Name (ARN) of the service"
  value       = try(aws_apprunner_service.this[0].arn, null)
}

output "service_id" {
  description = "An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region"
  value       = try(aws_apprunner_service.this[0].service_id, null)
}

output "service_url" {
  description = "A subdomain URL that App Runner generated for this service. You can use this URL to access your service web application"
  value       = try("https://${aws_apprunner_service.this[0].service_url}", null)
}

output "service_status" {
  description = "The current state of the App Runner service"
  value       = try(aws_apprunner_service.this[0].status, null)
}

################################################################################
# IAM Role - Access
################################################################################

output "access_iam_role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.access[0].name, null)
}

output "access_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = try(aws_iam_role.access[0].arn, null)
}

output "access_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.access[0].unique_id, null)
}

################################################################################
# IAM Role - Instance
################################################################################

output "instance_iam_role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.instance[0].name, null)
}

output "instance_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = try(aws_iam_role.instance[0].arn, null)
}

output "instance_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.instance[0].unique_id, null)
}

################################################################################
# Custom Domain Association
################################################################################

output "custom_domain_association_id" {
  description = "The `domain_name` and `service_arn` separated by a comma (`,`)"
  value       = try(aws_apprunner_custom_domain_association.this[0].id, null)
}

output "custom_domain_association_certificate_validation_records" {
  description = "A set of certificate CNAME records used for this domain name"
  value       = try(aws_apprunner_custom_domain_association.this[0].certificate_validation_records, null)
}

output "custom_domain_association_dns_target" {
  description = "The App Runner subdomain of the App Runner service. The custom domain name is mapped to this target name. Attribute only available if resource created (not imported) with Terraform"
  value       = try(aws_apprunner_custom_domain_association.this[0].dns_target, null)
}

################################################################################
# VPC Connector
################################################################################

output "vpc_connector_arn" {
  description = "The Amazon Resource Name (ARN) of VPC connector"
  value       = try(aws_apprunner_vpc_connector.this[0].arn, null)
}

output "vpc_connector_status" {
  description = "The current state of the VPC connector. If the status of a connector revision is INACTIVE, it was deleted and can't be used. Inactive connector revisions are permanently removed some time after they are deleted"
  value       = try(aws_apprunner_vpc_connector.this[0].status, null)
}

output "vpc_connector_revision" {
  description = "The revision of VPC connector. It's unique among all the active connectors (\"Status\": \"ACTIVE\") that share the same Name"
  value       = try(aws_apprunner_vpc_connector.this[0].vpc_connector_revision, null)
}

################################################################################
# Connection(s)
################################################################################

output "connections" {
  description = "Map of attribute maps for all connections created"
  value       = aws_apprunner_connection.this
}

################################################################################
# Auto-Scaling Configuration(s)
################################################################################

output "auto_scaling_configurations" {
  description = "Map of attribute maps for all autosclaing configurations created"
  value       = aws_apprunner_auto_scaling_configuration_version.this
}

################################################################################
# Observability Configuration
################################################################################

output "observability_configuration_arn" {
  description = "ARN of this observability configuration"
  value       = try(aws_apprunner_observability_configuration.this[0].arn, null)
}

output "observability_configuration_revision" {
  description = "The revision of the observability configuration"
  value       = try(aws_apprunner_observability_configuration.this[0].observability_configuration_revision, null)
}

output "observability_configuration_latest" {
  description = "Whether the observability configuration has the highest `observability_configuration_revision` among all configurations that share the same `observability_configuration_name`"
  value       = try(aws_apprunner_observability_configuration.this[0].latest, null)
}

output "observability_configuration_status" {
  description = "The current state of the observability configuration. An `INACTIVE` configuration revision has been deleted and can't be used. It is permanently removed some time after deletion"
  value       = try(aws_apprunner_observability_configuration.this[0].status, null)
}
