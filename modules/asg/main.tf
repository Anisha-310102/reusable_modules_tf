resource "aws_launch_configuration" "main" {
  name_prefix   = "${var.name}-lc-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-lc"
  }
}

resource "aws_autoscaling_group" "main" {
  launch_configuration = aws_launch_configuration.main.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  force_delete         = var.force_delete

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}-asg-instance"
      propagate_at_launch = true
    }
  ]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.name}-scale-up"
  scaling_adjustment     = var.scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_up_cooldown
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.name}-scale-down"
  scaling_adjustment     = var.scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_down_cooldown
  autoscaling_group_name = aws_autoscaling_group.main.name
}


