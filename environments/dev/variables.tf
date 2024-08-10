# Region
variable "region" {
  type = string
  default = "ap-south-1"
  description = "Aws region to deploy resources"
}

# VPC and Subnets
variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

# ECS Cluster
variable "cluster_name" {
  type = string
}

variable "family" {
  type = string
}

variable "network_mode" {
  type = string
}

variable "requires_compatibilities" {
  type = list(string)
}

variable "cpu" {
  type = string
}

variable "memory" {
  type = string
}

variable "image" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "host_port" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

variable "service_name" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "assign_public_ip" {
  type = bool
}

variable "lb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

# Security Groups and Networking
variable "allowed_cidrs" {
  type = list(string)
}

variable "github_token" {
  type = string
}

variable "environment" {
  type = string
}