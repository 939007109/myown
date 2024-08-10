provider "aws" {
    region = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

# data "terraform_remote_state" "dev" {
#   backend = "s3"

#   config = {
#     bucket = "ds1792-9acts-terraform-state-bucket"
#     key = "dev/terraform.tfstate"
#     region = "ap-south-1"
#   }
# }