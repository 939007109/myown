resource "aws_s3_bucket" "codebuild_bucket" {
  bucket = "${var.project_name}-build-artifacts-bucket"
  acl = "private"
  
  tags = {
    Name = "codebuild-bucket-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "codebuild_bucket_versioning" {
  bucket = aws_s3_bucket.codebuild_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}