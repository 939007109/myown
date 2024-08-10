terraform {
  backend "s3" {
    bucket = "project-9acts-terraform-state-bucket"
    key = "global/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
  }
}