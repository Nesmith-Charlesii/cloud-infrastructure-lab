variable "name" {
  description = "Name used for the VPC and related resources"
  type        = string
}

variable "environment" {
  description = "Environment for the VPC and related resources"
  type        = string
}

variable "region" {
  description = "AWS region for the VPC and related resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used by the subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create Nat Gateway resources"
  type        = bool
  default     = true
}