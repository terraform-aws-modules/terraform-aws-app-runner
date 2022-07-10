provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
  name   = "ex-${replace(basename(path.cwd), "_", "-")}"

  tags = {
    Example    = local.name
    Repository = "https://github.com/clowdhaus/terraform-aws-app-runner"
  }
}

################################################################################
# App Runner Module
################################################################################

module "app_runner_code_base" {
  source = "../.."

  service_name = "${local.name}-code-base2"

  source_configuration = {
    authentication_configuration = {
      connection_arn = aws_apprunner_connection.this.arn
    }
    auto_deployments_enabled = false
    code_repository = {
      code_configuration = {
        configuration_source = "REPOSITORY"
      }
      repository_url = "https://github.com/aws-containers/hello-app-runner"
      source_code_version = {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

  tags = local.tags
}


module "app_runner_image_base" {
  source = "../.."

  service_name = "${local.name}-image-base2"

  create_access_iam_role = true
  access_iam_role_policies = {
    "AWSAppRunnerServicePolicyForECRAccess" = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  }

  source_configuration = {
    # authentication_configuration = {
    #   connection_arn = aws_apprunner_connection.this.arn
    # }
    auto_deployments_enabled = false
    image_repository = {
      image_configuration = {
        port = 8000
      }
      image_identifier      = "public.ecr.aws/aws-containers/hello-app-runner:latest"
      image_repository_type = "ECR_PUBLIC"
    }
  }

  tags = local.tags
}

module "app_runner_disabled" {
  source = "../.."

  create = false
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_apprunner_connection" "this" {
  # The AWS Connector for GitHub connects to your GitHub account is a one-time setup,
  # You can reuse the connection for creating multiple App Runner services based on repositories in this account.
  # After creation, you must complete the authentication handshake using the App Runner console.
  connection_name = local.name
  provider_type   = "GITHUB"

  tags = local.tags
}

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

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for AppRunner connector"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["all-all"]

  egress_rules = ["all-all"]

  tags = local.tags
}
