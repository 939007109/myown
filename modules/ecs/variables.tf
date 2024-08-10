variable "cluster_name" {
    type = string
    description = "Name of the ECS cluster"
}

variable "family" {
  type = string
  description = "Family name of the ECS task definition"
}

variable "network_mode" {
  type = string
  description = "Network mode for ECS tasks"
  default = "awsvpc"
}

variable "requires_compatibilities" {
  type = list(string)
  description = "ECS task compatibility (Fargate, EC2)"
  default = [ "FARGATE" ]
}

variable "cpu" {
  type = string
  description = "Amount of CPU to allocate to the task"
}

variable "memory" {
  type = string
  description = "Amount of memory to allocate to the task"
}

variable "repository_url" {
  type = string
  description = "ECR repository URL"
}

variable "image_tag" {
  type = string
  description = "Docker image to use for the task"
}

variable "container_name" {
  type = string
  description = "Name of the container in the task"
  default = "php-app"
}

variable "container_port" {
  type = number
  description = "Port on which the container listens"
}

variable "host_port" {
  type = number
  description = "Host port to map to the container port"
}

variable "execution_role_arn" {
  type = string
  description = "ARN of the execution role for ECS tasks"
}

variable "service_name" {
    type = string
    description = "Name of the ECS service"
}

variable "desired_count" {
  type = number
  description = "Desired number of ECS task instances"
}

variable "launch_type" {
  type = string
  description = "ECS launch type (Fargate, EC2)"
  default = "FARGATE"
}

variable "private_subnets" {
  type = list(string)
  description = "List of subnet IDs for ECS tasks"
}

variable "security_groups" {
  type = list(string)
  description = "Security group ID for ECS tasks"
}

variable "assign_public_ip" {
  type = bool
  description = "Whether to assign a public IP to the ECS tasks"
  default = false
}

variable "target_group_arn" {
  type = string
  description = "ARN fo the target group for the ALB"
}

variable "environment" {
  type = string
  description = "Environment name (dev, prod)"
}
