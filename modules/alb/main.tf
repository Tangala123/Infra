resource "aws_lb" "selected" {
  name               = var.alb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
  ip_address_type    = "ipv4"
  vpc_id             = var.vpc_id 
}


resource "aws_lb_target_group" "selected" {
  name     = "${var.alb_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.selected.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.selected.arn
  }
}

output "alb_dns_name" {
  value = aws_lb.selected.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.selected.arn
}
