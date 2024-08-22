resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "/ecs/${replace(var.ecs_service_name, ":", "-")}"
  retention_in_days = 30
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name = "${var.environment}-ecs-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = "300"
  statistic = "Average"
  threshold = "80"
  #actions_enabled = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [var.cpu_scaling_policy_arn]
}

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name = "/aws/${var.vpc_name}/flow-logs"
}


resource "aws_flow_log" "vpc_flow_logs" {
  iam_role_arn    = var.vpc_flow_log_role
  log_group_name  = var.vpc_flow_logs_name
  vpc_id          = var.vpc_id
  traffic_type    = "ALL"
}