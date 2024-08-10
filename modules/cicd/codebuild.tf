
resource "aws_codebuild_project" "terraform_build" {
  name = "${var.project_name}-build"
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
        name  = "REPOSITOR-URI"
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

  # cache {
  #   type = "S3"
  #   location = "s3://${var.codebuild_bucket_id}/codebuild-cache"
  # }
}

# resource "aws_codebuild_project" "terraform_deploy" {
#     name = "${var.project_name}-deploy"
#     service_role = aws_iam_role.codebuild_role.arn
#     artifacts {
#         type = "CODEPIPELINE"
#     }
#     environment {
#       compute_type = "BUILD_GENERAL1_SMALL"
#       image = "aws/codebuild/standard:5.0"
#       type = "LINUX_CONTAINER"
#       environment_variable {
#             name  = "TF_VERSION"
#             value =  "1.3.0"
#         }
#     }
#     source {
#         type = "CODEPIPELINE"
#         buildspec = "deployspec.yaml"
#     }
# }