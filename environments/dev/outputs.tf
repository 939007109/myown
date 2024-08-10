output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns_name" {
    value = module.alb.alb_dns_name
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
    value = module.ecs.ecs_service_name
}

output "codebuild_role_arn" {
  value = module.iam.codebuild_role_arn
}

output "codepipeline_role_arn" {
  value = module.iam.codepipeline_role_arn
}

output "codebuild_bucket_id" {
  value = module.s3.codebuild_bucket_id
}
