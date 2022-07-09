variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Service
################################################################################

variable "service_name" {
  description = "The name of the service"
  type        = string
  default     = ""
}

variable "encryption_configuration" {
  description = "The encryption configuration for the service"
  type        = any
  default     = {}
}

variable "health_check_configuration" {
  description = "The health check configuration for the service"
  type        = any
  default     = {}
}

variable "instance_configuration" {
  description = "The instance configuration for the service"
  type        = any
  default     = {}
}

variable "network_configuration" {
  description = "The network configuration for the service"
  type        = any
  default     = {}
}

variable "source_configuration" {
  description = "The source configuration for the service"
  type        = any
  default     = {}
}

variable "auto_deployments_enabled" {
  description = "Whether auto deployments are enabled for the service"
  type        = bool
  default     = false
}

################################################################################
# VPC Connector
################################################################################

variable "create_vpc_connector" {
  description = "Determines whether a VPC Connector will be created"
  type        = bool
  default     = true
}

variable "vpc_connector_name" {
  description = "The name of the VPC Connector"
  type        = string
  default     = ""
}

variable "vpc_connector_subnets" {
  description = "The subnets to use for the VPC Connector"
  type        = list(string)
  default     = []
}

variable "vpc_connector_security_groups" {
  description = "The security groups to use for the VPC Connector"
  type        = list(string)
  default     = []
}

################################################################################
# Connection
################################################################################

variable "create_connection" {
  description = "Determines whether a connection will be created"
  type        = bool
  default     = true
}

variable "connection_name" {
  description = "The name of the connection"
  type        = string
  default     = ""
}

variable "connection_provider_type" {
  description = "The source repository provider. Valid values: `GITHUB`"
  type        = string
  default     = "GITHUB"
}

################################################################################
# Autoscaling
################################################################################

variable "create_autoscaling_configuration" {
  description = "Determines whether an Auto Scaling Configuration will be created"
  type        = bool
  default     = true
}

variable "autoscaling_configuration_arn" {
  description = "The ARN of an existing Auto Scaling Configuration"
  type        = string
  default     = null
}

variable "autoscaling_name" {
  description = "The name of the auto scaling configuration"
  type        = string
  default     = null
}

variable "autoscaling_max_concurrency" {
  description = "The maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service"
  type        = number
  default     = null
}

variable "autoscaling_max_size" {
  description = "The maximal number of instances that App Runner provisions for your service"
  type        = number
  default     = 1
}

variable "autoscaling_min_size" {
  description = "The minimal number of instances that App Runner provisions for your service"
  type        = number
  default     = 1
}

################################################################################
# Custom Domain Association
################################################################################

variable "create_custom_domain_association" {
  description = "Determines whether a Custom Domain Association will be created"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The custom domain endpoint to association. Specify a base domain e.g., `example.com` or a subdomain e.g., `subdomain.example.com`"
  type        = string
  default     = ""
}

variable "enable_www_subdomain" {
  description = "Whether to associate the subdomain with the App Runner service in addition to the base domain. Defaults to `true`"
  type        = bool
  default     = null
}

variable "hosted_zone_id" {
  description = "The ID of the Route53 hosted zone that contains the domain for the `domain_name`"
  type        = string
  default     = ""
}

################################################################################
# Observability Configuration
################################################################################

variable "enable_observability_configuration" {
  description = "Determines whether an Observability Configuration will be created"
  type        = bool
  default     = true
}

variable "observability_configuration_name" {
  description = "The name of the Observability Configuration"
  type        = string
  default     = ""
}

variable "observability_trace_configuration" {
  description = "The name of the Trace Configuration"
  type        = any
  default     = {}
}
