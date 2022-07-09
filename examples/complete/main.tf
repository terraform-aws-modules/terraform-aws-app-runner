provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
  name   = "app-runner-ex-${replace(basename(path.cwd), "_", "-")}"

  tags = {
    Example    = local.name
    Repository = "https://github.com/clowdhaus/terraform-aws-app-runner"
  }
}

################################################################################
# App Runner Module
################################################################################

module "app_runner_disabled" {
  source = "../.."

  create = false
}

module "app_runner" {
  source = "../.."

  create = false

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.99.0.0/18"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

  enable_nat_gateway      = false
  single_nat_gateway      = true
  map_public_ip_on_launch = false

  tags = local.tags
}
