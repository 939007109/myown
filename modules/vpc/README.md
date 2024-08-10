# VPC Module

This module provisions a Virtual Private Cloud (VPC) along with subnets, route tables, Internet Gateways, and NAT Gateways.

## Inputs

- `vpc_name`: The name of the VPC.
- `cidr_block`: The CIDR block for the VPC.
- `public_subnets`: List of CIDR blocks for public subnets
- `private_subnets`: List of CIDR blocks for private subnets
- `availability_zones`: List of availability zones for the subnets
- `allocation_ids`: Elastic IP allocation IDs for NAT gateways
- `tags`: Tags to apply to the VPC and its resources.

## Outputs

- `vpc_id`: The ID of the VPC
- `public_subnets`: List of IDs of public subnets
- `private_subnets`: List of IDs of private subnets

