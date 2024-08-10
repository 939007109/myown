resource "aws_codepipeline" "global_pipeline" {
  name = "Global_Infrastructure-Pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    type = "S3"
    location = var.codebuild_bucket_id
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
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.global_build.name
      }
    }
  }
}