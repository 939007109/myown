module "php-app-dev" {
    source = "../../modules/cicd"
    project_name = "9acts-php-app"
    environment  = "dev"
    github_owner = "name"
    app_name    = "php-app"
    github_repo = "project-9acts"
    github_branch = "main"
    github_token = var.github_token

    codebuild_role_arn     =    module.iam.codebuild_role_arn
    codepipeline_role_arn  =    module.iam.codepipeline_role_arn
    codebuild_bucket_id    =    module.s3.codebuild_bucket_id
    repository_url = module.ecr.repository_url
    ecs_cluster_name    =   module.ecs.ecs_cluster_name
    ecs_service_name    =   module.ecs.ecs_service_name
}
