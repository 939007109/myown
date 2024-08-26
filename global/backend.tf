terraform {
  backend "s3" {
    bucket = "project-9acts-terraform-state-bucket123"
    key = "global/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}
