resource "aws_codebuild_project" "global_build" {
  name = "Global-Infrastructure-Build"

  service_role = var.codebuild_role_arn
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:5.0"
    type = "LINUX_CONTAINER"
  }

  source {
    type = "S3"
    location = "${var.codebuild_bucket_id}/global.zip"
    buildspec = "buildspec_global.yml"
  }
}