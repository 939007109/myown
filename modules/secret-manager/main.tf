resource "aws_secretsmanager_secret" "githib_token" {
  name = "github-token"
  description = "GitHub token for accessing repository"
}

resource "aws_secretsmanager_secret_version" "github_token_value" {
  secret_id = aws_secretsmanager_secret.githib_token.id
  secret_string = var.githib_token
}