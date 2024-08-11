
resource "aws_s3_bucket" "terraform_state" {
  bucket = "project-9acts-terraform-state-bucket"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags = {
        Name        = "Terraform State Bucket"
        Environment = "Global"
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }

    tags = {
      Name        = "Terraform State Locks Table"
      Environment = "Global"
    }
}
