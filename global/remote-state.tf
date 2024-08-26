data "terraform_remote_state" "dev" {
    backend = "s3"

    config = {
      bucket = "project-9acts-terraform-state-bucket123"
      key = "environments/dev/terraform.tfstate"
      region = "us-east-1"
    }
}
