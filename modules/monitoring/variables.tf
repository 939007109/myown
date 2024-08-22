variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "cpu_scaling_policy_arn" {
  type = string
}

# variable "cpu_scale_down_policy_arn" {
#   type = string
# }

variable "environment" {
  type = string
}