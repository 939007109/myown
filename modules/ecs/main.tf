resource "aws_ecs_cluster" "ecs-cluster" {
    name = var.cluster_name

    tags = {
        Name = var.cluster_name
        Environment = var.environment
    }
}

resource "aws_ecs_task_definition" "php" {
    family                   = "${var.environment}-php-app"
    network_mode             = var.network_mode
    requires_compatibilities = var.requires_compatibilities
    cpu                      = var.cpu
    memory                   = var.memory

    container_definitions = jsonencode([
        {
            name       = var.container_name
            image      = "${var.repository_url}:${var.image_tag}" 
            essential  = true
            portMappings = [
                {
                    containerPort = var.container_port
                    hostPort      = var.host_port
                }
            ]
        }
    ])

    execution_role_arn  =   var.execution_role_arn

    tags = {
        Name = "var.cluster_name"
        Environment = var.environment
    }
}

resource "aws_ecs_service" "php" {
    name            = var.service_name
    cluster         = aws_ecs_cluster.ecs-cluster.id
    task_definition = aws_ecs_task_definition.php.arn
    desired_count = var.desired_count
    launch_type = var.launch_type

    network_configuration {
        subnets = var.private_subnets
        security_groups = var.security_groups
        assign_public_ip = var.assign_public_ip
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name   = var.container_name
        container_port   = var.container_port
    }

    tags = {
      Name = var.service_name
      Environment = var.environment
    }
}

resource "aws_appautoscaling_target" "ecs" {
  max_capacity = 10
  min_capacity = 2
  resource_id = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.php.name}"
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

