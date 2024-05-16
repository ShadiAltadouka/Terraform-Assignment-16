resource "aws_launch_template" "lt-1" {
  name                   = "launch_template-1"
  image_id               = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  user_data              = base64encode (<<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo vi /var/www/html/index.html
        sudo echo this is $HOSTNAME >> /var/www/html/index.html
        EOF
  )
  vpc_security_group_ids = [aws_security_group.atlas-sg.id]

  placement {
    availability_zone = var.availability_zone

  }
}

resource "aws_autoscaling_group" "asg-1" {
  name                      = "auto-scaling-1"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 60
  vpc_zone_identifier       = [aws_subnet.pub-subnet.id]

  launch_template {
    id = aws_launch_template.lt-1.id
    version = aws_launch_template.lt-1.latest_version
  }

  depends_on = [aws_launch_template.lt-1]

}

