output "aws_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.ecs_task_logs.name
}

output "aws_cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.ecs_task_logs.arn
}

output "vpc_flow_logs_name" {
  value = aws_cloudwatch_log_group.vpc_flow_logs.name
}