
resource "aws_codebuild_project" "app_build" {
  name = "${var.environment}-${var.app_name}-build"
  description = "CI/CD for Terraform deployments"
  build_timeout = 30
  service_role = var.codebuild_role_arn
  
  artifacts {
    type = "NO_ARTIFACTS"
  }
  
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:5.0"
    type = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
        name  = "REPOSITORY-URI"
        value =  var.repository_url
      }
    environment_variable {
      name  = "IMAGE_TAG"
      value =  "latest"
     }
  }
  source {
    type    = "GITHUB"
    location = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = "buildspec.yaml"  
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.project_name}-build"
      status = "ENABLED"
    }
  }

  cache {
    type = "S3"
    location = "${var.codebuild_bucket_id}/codebuild-cache"
  }
}
