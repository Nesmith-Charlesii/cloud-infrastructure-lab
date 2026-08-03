locals {
  environment = "dev"

  environment_tags = {
    Environment = local.environment
  }
}