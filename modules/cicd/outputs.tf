output "pipeline_name" {
  value = aws_codepipeline.app_pipeline.name
}

output "build_name" {
  value = aws_codebuild_project.app_build.name
}