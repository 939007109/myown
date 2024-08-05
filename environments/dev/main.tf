provider "aws" {
    region = var.region
}

module "vpc" {
    source = "../../modules/vpc"

    vpc_name = var.vpc_name
    cidr_block = var.cidr_block
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    availability_zones = var.availability_zones
    #allocation_ids  =  [aws_eip.eip_nat[*].id]
    environment =  var.environment
}

module "iam" {
    source = "../../modules/iam"
    
    environment = var.environment
}

module "security" {
  source = "../../modules/security"

  vpc_id = module.vpc.vpc_id
  lb_name = var.lb_name
  ecs_cluster_name  =   var.cluster_name
  ecs_container_port   =    var.container_port
  allowed_cidrs =   var.allowed_cidrs
  environment   =   var.environment
}

module "alb" {
    source = "../../modules/alb"

    lb_name = var.lb_name
    alb_sg_id = [module.security.alb_sg_id]
    subnets =   module.vpc.public_subnet_ids
    target_group_name   =   var.target_group_name
    vpc_id  =   module.vpc.vpc_id
    environment =   var.environment
}

module "ecs" {
    source = "../../modules/ecs"

    cluster_name = var.cluster_name
    family  =   var.family
    network_mode    = var.network_mode
    requires_compatibilities    =   var.requires_compatibilities
    cpu = var.cpu
    memory  =   var.memory
    image   =   var.image
    container_name  =   var.container_name
    container_port  =   var.container_port
    host_port       =   var.host_port
    execution_role_arn  =   module.iam.ecs_task_execution_role_arn
    service_name    =   var.service_name
    desired_count   =   var.desired_count
    private_subnets =   module.vpc.private_subnet_ids
    security_groups =   [module.security.ecs_sg_id]
    assign_public_ip    =   var.assign_public_ip
    target_group_arn    =   module.alb.target_group_arn
    environment =   var.environment
}