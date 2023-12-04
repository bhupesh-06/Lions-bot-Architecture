#--- loadbalancing/outputs.tf ---

output "elb" {
  value = aws_lb.my_lb.id
}

output "alb_tg" {
  value = aws_lb_target_group.my_tg.arn
}

output "alb_dns" {
  value = aws_lb.my_lb.dns_name
}
