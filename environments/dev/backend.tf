terraform {
  backend "s3" {
    bucket = "ds1792-9acts-terraform-state-bucket"
    key = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}