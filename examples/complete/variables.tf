variable "repository_url" {
  description = "Location of the repository that contains the source code. Repository must be located in same scope as the GitHub connection (user's profile or organization)"
  type        = string
  default     = "https://github.com/aws-containers/hello-app-runner" # clone to your account associated with the GitHub connection
}

variable "hosted_zone_id" {
  description = "The Route53 zone ID where the validation records for the custom domain will be created"
  type        = string
  default     = "Z0975817WMT8ITN8W25F"
}
