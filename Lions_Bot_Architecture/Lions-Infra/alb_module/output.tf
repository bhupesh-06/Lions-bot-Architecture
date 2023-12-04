#--- loadbalancing/outputs.tf ---

output "elb1" {
  value = aws_lb.my_lb1.id
}

output "alb_tg1" {
  value = aws_lb_target_group.my_tg1.arn
}

output "alb_dns1" {
  value = aws_lb.my_lb1.dns_name
}
