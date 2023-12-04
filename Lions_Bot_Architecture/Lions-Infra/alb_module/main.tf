
resource "aws_lb" "my_lb1" {
  name               = "my-loadbalancer1"
  internal           = false
  load_balancer_type = "application"
  subnets            = tolist(var.public_subnets1)

  
}
resource "aws_lb_target_group" "my_tg1" {
  name     = "my-lb-tg1"
  protocol = var.tg_protocol1
  port     = var.tg_port1
  vpc_id   = var.vpc1_id
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

resource "aws_lb_listener" "my_lb_listener1" {
  load_balancer_arn = aws_lb.my_lb1.arn
  port              = var.listener_port1
  protocol          = var.listener_protocol1
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg1.arn
  }
}