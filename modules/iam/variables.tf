variable "region" {
  type = string
  description = "aws region"
}

variable "environment" {
  type = string
  description = "Environment name (dev, prod)"
}

variable "codebuild_bucket_id" {
  type = string
}
