locals {
  env_config = {
    dev = {
      owner = "dev-team"
    }
    staging = {
      owner = "qa-team"
    }
    prod = {
      owner = "ops-team"
    }
  }

  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = local.env_config[var.environment].owner
  }
}