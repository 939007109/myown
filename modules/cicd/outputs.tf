output "pipeline_name" {
  value = aws_codepipeline.cicd_pipeline.name
}

output "build_name" {
  value = aws_codebuild_project.terraform_build.name
}