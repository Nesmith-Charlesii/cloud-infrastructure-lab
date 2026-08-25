resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.name
    Environment = var.environment
    Region = var.region
  }
}