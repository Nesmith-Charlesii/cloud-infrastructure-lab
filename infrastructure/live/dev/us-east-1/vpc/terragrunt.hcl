include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/vpc"
}

inputs = {
  vpc_cidr = "10.0.0.0/16"

  public_subnets_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets_cidrs = [
    "10.0.10.0/24",
    "10.0.11.0/24"
  ]
}

