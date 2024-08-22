output "cpu_scale_up_policy_arn" {
  value = aws_appautoscaling_policy.cpu_scale.arn
}

# output "cpu_scale_down_policy_arn" {
#   value = aws_appautoscaling_policy.cpu_scale_down.arn
# }