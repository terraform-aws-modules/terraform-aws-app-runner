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

variable "enable_autoscaling" {
  description = "Determines whether an Auto Scaling Configuration will be created"
  type        = bool
  default     = true
}

variable "autoscaling_name" {
  description = "The name of the auto scaling configuration"
  type        = string
  default     = ""
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
