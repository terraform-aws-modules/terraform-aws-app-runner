################################################################################
# Service
################################################################################

################################################################################
# VPC Connector
################################################################################

output "vpc_connector_arn" {
  description = "The Amazon Resource Name (ARN) of VPC connector"
  value       = try(aws_apprunner_vpc_connector.this[0].vpc_connector_arn, null)
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
# Connection
################################################################################

output "connection_arn" {
  description = "The Amazon Resource Name (ARN) of the connection"
  value       = try(aws_apprunner_connection.this[0].arn, null)
}

output "connection_status" {
  description = "The current state of the App Runner connection. When the state is `AVAILABLE`, you can use the connection to create an aws_apprunner_service resource"
  value       = try(aws_apprunner_connection.this[0].status, null)
}

################################################################################
# Autoscaling
################################################################################
