variable "vpc_id" {
  type = string
  description = "VPC ID where the security group will be deployed"
}

variable "lb_name" {
  type = string
  description = "Name of the Load Balancer"
}

variable "ecs_cluster_name" {
  type = string
  description = "Name of the ECS Cluster"
}

variable "ecs_container_port" {
  type = number
  description = "Port on which the ECS container listens"
}

variable "allowed_cidrs" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
  description = "List of allowed CIDR blocks for the ECS service"
}

variable "environment" {
  type = string
  description = "Environment name (dev, prod)"
}
