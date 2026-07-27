locals {
    aws_region = "us-east-1"

    region_tags = {
        Region = local.aws_region
    }
}