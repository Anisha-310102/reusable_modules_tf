resource "aws_lb" "main" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = "${var.name}.alb"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.name}-target-group"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  tags = {
    Name = "${var.name}.target-group"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Name = "${var.name}.listener"
  }
}

