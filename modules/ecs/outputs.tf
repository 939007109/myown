output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs-cluster.id
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.php.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs-cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.php.id
}

output "cpu_scaling_policy_arn" {
  value = aws_appautoscaling_policy.cpu_scale.arn
}

# output "cpu_scale_down_policy_arn" {
#   value = aws_appautoscaling_policy.cpu_scale_down.arn
# }