output "github_token_secret_arn" {
  value = aws_secretsmanager_secret.github_token.arn
}

output "github_token_secret_id" {
  value = aws_secretsmanager_secret.github_token.id
}