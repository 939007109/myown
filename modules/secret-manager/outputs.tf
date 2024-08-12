output "githib_token_secret_arn" {
  value = aws_secretsmanager_secret.githib_token.arn
}

output "githib_token_secret_id" {
  value = aws_secretsmanager_secret.githib_token.id
}