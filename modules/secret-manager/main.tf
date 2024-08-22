resource "aws_secretsmanager_secret" "github_token" {
  name = "github_token"
  description = "GitHub token for accessing repository"
}

resource "aws_secretsmanager_secret_version" "github_token_value" {
  secret_id = aws_secretsmanager_secret.github_token.id
  secret_string = var.github_token
}