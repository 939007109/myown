variable "lb_name" {
    type        = string
    description = "Name of the load balancer"
}

variable "alb_sg_id" {
  type = list(string)
  description = "List of security group IDs for the ALB"
}

variable "subnets" {
  type = list(string)
  description = "List of subnet IDs for the ALB"
}

variable "target_group_name" {
  type = string
  description = "Name of the target group"
}

variable "lb_port" {
  type = number
  default = 80
}

variable "lb_protocol" {
  type = string
  default = "HTTP"
  description = "Protocol for the load balancer"
}


variable "vpc_id" {
  type = string
  description = "VPC ID where the load balancer will be deployed"
}

variable "listener_port" {
  type = number
  description = "Port on which the listener listens"
  default = 80
}

variable "listener_protocol" {
  type = string
  description = "Protocol for the listener"
  default = "HTTP"
}

variable "health_check_path" {
  description = "Path for the health check"
  type = string
  default = "/"
}

variable "environment" {
  type = string
  description = "Environment name (dev, prod)"
}