resource "aws_lb" "alb" {
  name  =   var.lb_name
  internal = false
  load_balancer_type =   "application"
  security_groups = var.alb_sg_id
  subnets = var.subnets

  tags = {
    Name = var.lb_name
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "php-tg" {
    name = var.target_group_name
    port = var.lb_port
    protocol = var.lb_protocol
    vpc_id = var.vpc_id
    target_type = "ip"

    health_check {
      path = var.health_check_path
      interval = 30
      timeout = 5
      healthy_threshold = 5
      unhealthy_threshold = 2
      matcher = "200"
    }

    tags = {
        Name = var.target_group_name
        Environment = var.environment
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.php-tg.arn
  }

  tags = {
    Name = "${var.lb_name}-listener"
    Environment = var.environment
  }
}