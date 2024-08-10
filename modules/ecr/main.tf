resource "aws_ecr_repository" "app_repo" {
    name = var.repo_name

    image_scanning_configuration {
        scan_on_push    =   true
    }

    image_tag_mutability = "MUTABLE"
    
    tags = {
        Name    =   var.repo_name
        Environment =   var.environment
    }
}