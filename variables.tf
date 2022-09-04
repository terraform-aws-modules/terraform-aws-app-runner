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

variable "create_service" {
  description = "Determines whether the service will be created"
  type        = bool
  default     = true
}

variable "service_name" {
  description = "The name of the service"
  type        = string
  default     = ""
}

variable "auto_scaling_configuration_arn" {
  description = "ARN of an App Runner automatic scaling configuration resource that you want to associate with your service. If not provided, App Runner associates the latest revision of a default auto scaling configuration"
  type        = string
  default     = null
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

variable "observability_configuration" {
  description = "The observability configuration for the service"
  type        = any
  default     = {}
}

variable "source_configuration" {
  description = "The source configuration for the service"
  type        = any
  default     = {}
}

################################################################################
# IAM Role - Access
################################################################################

variable "create_access_iam_role" {
  description = "Determines whether an IAM role is created or to use an existing IAM role"
  type        = bool
  default     = false
}

variable "access_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "access_iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "access_iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "access_iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "access_iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "private_ecr_arn" {
  description = "The ARN of the private ECR repository that contains the service image to launch"
  type        = string
  default     = null
}

variable "access_iam_role_policies" {
  description = "IAM policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Role - Instance
################################################################################

variable "create_instance_iam_role" {
  description = "Determines whether an IAM role is created or to use an existing IAM role"
  type        = bool
  default     = true
}

variable "instance_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "instance_iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "instance_iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "instance_iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "instance_iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "instance_iam_role_policies" {
  description = "IAM policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

################################################################################
# Custom Domain Association
################################################################################

variable "create_custom_domain_association" {
  description = "Determines whether a Custom Domain Association will be created"
  type        = bool
  default     = false
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

# variable "hosted_zone_id" {
#   description = "The ID of the Route53 hosted zone that contains the domain for the `domain_name`"
#   type        = string
#   default     = ""
# }

################################################################################
# VPC Connector
################################################################################

variable "create_vpc_connector" {
  description = "Determines whether a VPC Connector will be created"
  type        = bool
  default     = false
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
# VPC Connector - Security Group
################################################################################

variable "create_security_group" {
  description = "Determines if a security group is created for the VPC connector"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where the security will be provisioned"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "Description for the security group created"
  type        = string
  default     = null
}

variable "security_group_rules" {
  description = "List of security group rules to add to the security group created"
  type        = any
  default     = {}
}

################################################################################
# Connection(s)
################################################################################

variable "connections" {
  description = "Map of connection definitions to create"
  type        = any
  default     = {}
}

################################################################################
# Autoscaling Configuration(s)
################################################################################

variable "auto_scaling_configurations" {
  description = "Map of auto-scaling configuration definitions to create"
  type        = any
  default     = {}
}

################################################################################
# Observability Configuration(s)
################################################################################

variable "observability_configurations" {
  description = "Map of observability configuration definitions to create"
  type        = any
  default     = {}
}
