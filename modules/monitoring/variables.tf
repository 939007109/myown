variable "vpc_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "cpu_scaling_policy_arn" {
  type = string
}

variable "vpc_flow_logs_name" {
  type = string
}

variable "vpc_flow_log_role" {
  type = string
}

variable "vpc_id" {
  type = string
}


variable "environment" {
  type = string
}