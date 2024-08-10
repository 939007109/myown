terraform {
  backend "s3" {
    bucket = "project-9acts-terraform-state-bucket"
    key = "environments/dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}