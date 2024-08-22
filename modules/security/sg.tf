resource "aws_security_group" "alb_sg" {
  name = "${var.lb_name}-sg"
  description = "Allow HTTP and HTTPS traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.lb_name}-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "ecs_sg" {
  name = "${var.ecs_cluster_name}-sg"
  description = "Allow traffic to ECS services"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ecs_container_port
    to_port     = var.ecs_container_port
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecs_cluster_name}-ecs-sg"
    Environment = var.environment
  }
}
