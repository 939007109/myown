resource "aws_appautoscaling_target" "ecs" {
  max_capacity = 10
  min_capacity = 2
  resource_id = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_scale_up" {
  name = "cpu-scale-up"
  service_namespace = "ecs"
  resource_id = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = 80.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    scale_in_cooldown = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_policy" "cpu_scale_down" {
  name = "cpu-scale-down"
  service_namespace = "ecs"
  resource_id = aws_appautoscaling_target.ecs.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs.scalable_dimension
  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = 30.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    
    scale_in_cooldown = 300
    scale_out_cooldown = 300
  }
}

