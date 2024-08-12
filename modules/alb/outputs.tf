output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}

output "target_group_arn" {
    value = aws_lb_target_group.php-tg.arn
}

output "listener_arn" {
 value = aws_lb_listener.http.arn
}