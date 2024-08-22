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

variable "vpc_flow_logs_name" {
  type = string
}

variable "vpc_id" {
  type = string
}
