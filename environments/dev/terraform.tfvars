region = "ap-south-1"

## VPC
vpc_name = "dev-vpc"
cidr_block  =   "10.0.0.0/16"
public_subnets  =   ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["ap-south-1a", "ap-south-1b"]

## ECS-CLUSTER
cluster_name = "dev-ecs-cluster"
family       = "php-app"
network_mode =  "awsvpc"
requires_compatibilities   =    ["FARGATE"]
cpu = "256"
memory = "512"
image        = "php:latest"
container_name = "php-app"
container_port  =   80
host_port   =   80
execution_role_arn = ""
service_name = "php-service"
desired_count = 2
assign_public_ip   = false
lb_name     =   "dev-alb"
target_group_name = "dev-tg"
allowed_cidrs   =   ["0.0.0.0/0"]
environment =  "dev"
