resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "/ecs/${replace(var.ecs_service_name, ":", "-")}"
  retention_in_days = 30
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

  alarm_actions = [var.cpu_scale_up_policy_arn]
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_low" {
  alarm_name = "${var.environment}-ecs-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = "300"
  statistic = "Average"
  threshold = "30"
  #actions_enabled = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [var.cpu_scale_down_policy_arn]
}