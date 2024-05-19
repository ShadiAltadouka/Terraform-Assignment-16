resource "aws_autoscaling_group" "asg-1" {
  name                      = "auto-scaling-1"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 60
  vpc_zone_identifier = [
    aws_subnet.pub-subnet.id,
    aws_subnet.pub-subnet-2.id
  ]

  target_group_arns = [aws_lb_target_group.tg-1.arn]

  launch_template {
    id      = aws_launch_template.lt-1.id
    version = aws_launch_template.lt-1.latest_version
  }

  depends_on = [
    aws_lb_target_group.tg-1,
    aws_launch_template.lt-1,
    aws_lb.alb-1,
  ]

}

resource "aws_autoscaling_attachment" "asg-register" {
  autoscaling_group_name = aws_autoscaling_group.asg-1.id
  lb_target_group_arn    = aws_lb_target_group.tg-1.id

  depends_on = [aws_autoscaling_group.asg-1]

}

resource "aws_launch_template" "lt-1" {
  name          = "launch_template-1"
  image_id      = var.ubuntu_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data = base64encode(<<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo echo this is $HOSTNAME >> /var/www/html/index.html
        EOF
  )
  vpc_security_group_ids = [aws_security_group.atlas-sg.id]

  placement {
    availability_zone = var.availability_zone

  }
}

resource "aws_lb" "alb-1" {
  name               = "application-elb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.pub-subnet.id,
    aws_subnet.pub-subnet-2.id
  ]
  security_groups = [aws_security_group.atlas-sg.id]

  depends_on = [aws_lb_target_group.tg-1]

}

resource "aws_lb_listener" "alb-1-listener" {
  load_balancer_arn = aws_lb.alb-1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg-1.arn
    type             = "forward"
  }

  depends_on = [aws_lb_target_group.tg-1]

}

resource "aws_lb_target_group" "tg-1" {
  name        = "application-target-group-1"
  load_balancing_algorithm_type = "round_robin"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.atlas-vpc.id

}