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


module "security" {
  source = "../../modules/security"

  vpc_id = module.vpc.vpc_id
  lb_name = var.lb_name
  ecs_cluster_name  =   var.cluster_name
  ecs_container_port   =    var.container_port
  allowed_cidrs =   var.allowed_cidrs
  environment   =   var.environment
}


module "iam" {
    source = "../../modules/iam"
    depends_on = [ module.s3 ]
    
    environment = var.environment
    codebuild_bucket_id = module.s3.codebuild_bucket_id
}

module "s3" {
    source = "../../modules/s3"
    environment = var.environment
    project_name = "php-app"
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

module "ecr" {
    source = "../../modules/ecr"

    repo_name = "php-app"
    environment = var.environment
}

module "ecs" {
    source = "../../modules/ecs"

    region = var.region
    cluster_name = var.cluster_name
    family  =   var.family
    network_mode    = var.network_mode
    requires_compatibilities    =   var.requires_compatibilities
    cpu = var.cpu
    memory  =   var.memory
    repository_url = module.ecr.repository_url
    image_tag =   "latest"
    container_name  =   var.container_name
    container_port  =   var.container_port
    host_port       =   var.host_port
    #ecs_cloudwatch_log_group_name    = var.ecs_cloudwatch_log_group_name
    execution_role_arn  =   module.iam.ecs_task_execution_role_arn
    service_name    =   var.service_name
    desired_count   =   var.desired_count
    private_subnets =   module.vpc.private_subnet_ids
    security_groups =   [module.security.ecs_sg_id]
    assign_public_ip    =   var.assign_public_ip
    target_group_arn    =   module.alb.target_group_arn
    environment =   var.environment

    #depends_on = [ module.monitoring ]
}

module "monitoring" {
  source = "../../modules/monitoring"
  environment = var.environment
  ecs_cluster_name = module.ecs.ecs_cluster_name
  ecs_service_name = module.ecs.ecs_service_name
  cpu_scale_up_policy_arn = module.ecs.cpu_scale_up_policy_arn
  cpu_scale_down_policy_arn = module.ecs.cpu_scale_down_policy_arn
}

module "secret-manager" {
  source = "../../modules/secret-manager"

  githib_token = var.github_token
}

module "route53" {
  source = "../../modules/route53"

  domain_name = "project-9acts.com"
  subdomain_name = "php-app-dev.project-9acts.com"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id

  depends_on = [module.alb]
}