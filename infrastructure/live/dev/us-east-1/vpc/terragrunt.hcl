include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  name = include.root.locals.project_name

  environment_config = read_terragrunt_config(
    find_in_parent_folders("environment.hcl")
  )

  region_config = read_terragrunt_config(
    find_in_parent_folders("region.hcl")
  )

  environment = local.environment_config.locals.environment
  region = local.region_config.locals.aws_region
}


terraform {
  source = "${get_repo_root()}/infrastructure/modules/vpc"
}

inputs = {
  name = "${local.name}"

  environment = local.environment
  region = local.region

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.10.0/24",
    "10.0.11.0/24"
  ]
}