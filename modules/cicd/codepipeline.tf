resource "aws_codepipeline" "cicd_pipeline" {
    name = "${var.app_name}-${var.environment}-pipeline"

    role_arn =  var.codepipeline_role_arn

    artifact_store {
      location = var.codebuild_bucket_id
      type  =   "S3"
    }

    stage {
        name = "Source"
        
        action {
            name = "Source"
            category = "Source"
            owner = "ThirdParty"
            provider = "GitHub"
            version = "1"
            output_artifacts = ["source_output"]
            
            configuration = {
              # S3Bucket = aws_s3_bucket.codebuild_bucket.id
              # S3ObjectKey = "source.zip"
              Owner     =   var.github_owner
              Repo      =   var.github_repo
              Branch    =   var.github_branch
              OAuthToken=   var.github_token
            }
        }
    }

    stage {
      name = "Build"
      
      action {
        name = "Build"
        category = "Build"
        owner   =   "AWS"
        provider = "CodeBuild"
        version = "1"
        input_artifacts = ["source_output"]
        output_artifacts = ["build_output"]
        configuration = {
          ProjectName = aws_codebuild_project.terraform_build.name
        }
      }
    }

    stage {
        name = "Deploy"
        
        action {
          name = "Deploy"
          category = "Deploy"
          owner = "AWS"
          provider = "ECS"
          version = "1"
          input_artifacts = ["build_output"]

          configuration = {
            ClusterName = var.ecs_cluster_name
            ServiceName = var.ecs_service_name
            FileName    = "imagedefinitions.json"
        }
    }
  }
}