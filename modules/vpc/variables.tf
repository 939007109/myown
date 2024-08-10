variable "vpc_name" {
    type = string
    description = "Name of the VPC"
}

variable "cidr_block" {
    type = string
    description = "CIDR block for the VPC"
}

variable "public_subnets" {
    type = list(string)
    description = "List of public subnets CIDR blocks"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets CIDR blocks"
}

variable "availability_zones" {
    type = list(string)
    description = "List of availability zones"
}

# variable "allocation_ids" {
#   description = "Elastic IP allocation IDs for the NAT Gateway"
#   type = list(string)
# }

variable "environment" {
  description = "Environment name (dev, prod)"
  type = string
}