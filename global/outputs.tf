# output "pipeline_name" {
#   value = module.php-app-dev.pipeline_name
# }

output "terraform_remote_state" {
  value = aws_s3_bucket.terraform_state.id
}