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

module "app_runner_shared_configs" {
  source = "../.."

  # Disable service resources
  create_service = false

  connections = {
    # The AWS Connector for GitHub connects to your GitHub account is a one-time setup,
    # You can reuse the connection for creating multiple App Runner services based on repositories in this account.
    # After creation, you must complete the authentication handshake using the App Runner console.
    github = {
      provider_type = "GITHUB"
    }
  }

  auto_scaling_configurations = {
    mini = {
      name            = "mini"
      max_concurrency = 20
      max_size        = 5
      min_size        = 1

      tags = {
        Type = "Mini"
      }
    }

    mega = {
      name            = "mega"
      max_concurrency = 200
      max_size        = 25
      min_size        = 5

      tags = {
        Type = "MEGA"
      }
    }
  }

  tags = local.tags
}

module "app_runner_code_base" {
  source = "../.."

  service_name = "${local.name}-code-base"

  # Pulling from shared configs
  auto_scaling_configuration_arn = module.app_runner_shared_configs.auto_scaling_configurations["mini"].arn

  source_configuration = {
    authentication_configuration = {
      # Pulling from shared configs
      connection_arn = module.app_runner_shared_configs.connections["github"].arn
    }
    auto_deployments_enabled = false
    code_repository = {
      code_configuration = {
        configuration_source = "REPOSITORY"
      }
      repository_url = "https://github.com/clowdhaus/hello-app-runner"
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

  service_name = "${local.name}-image-base"

  # Pulling from shared configs
  auto_scaling_configuration_arn = module.app_runner_shared_configs.auto_scaling_configurations["mega"].arn

  source_configuration = {
    auto_deployments_enabled = false
    image_repository = {
      image_configuration = {
        port = 8000
      }
      image_identifier      = "public.ecr.aws/aws-containers/hello-app-runner:latest"
      image_repository_type = "ECR_PUBLIC"
    }
  }

  # # Requires manual intervention to validate records
  # create_custom_domain_association = true
  # hosted_zone_id                   = "Z067530812I2IA0AIKZEV"
  # domain_name                      = "apprunner.sharedservices.clowd.haus"
  # enable_www_subdomain             = true

  create_vpc_connector          = true
  vpc_connector_subnets         = module.vpc.private_subnets
  vpc_connector_security_groups = [module.security_group.security_group_id]
  network_configuration = {
    egress_configuration = {
      egress_type = "VPC"
    }
  }

  enable_observability_configuration = true

  tags = local.tags
}

module "app_runner_disabled" {
  source = "../.."

  create = false
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

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for AppRunner connector"
  vpc_id      = module.vpc.vpc_id

  egress_rules       = ["http-80-tcp"]
  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

  tags = local.tags
}
