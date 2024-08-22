data "terraform_remote_state" "dev" {
    backend = "s3"

    config = {
      bucket = "project-9acts-terraform-state-bucket"
      key = "environments/dev/terraform.tfstate"
      region = "ap-south-1"
    }
}