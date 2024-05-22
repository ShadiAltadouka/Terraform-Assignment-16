resource "aws_instance" "ec2-ubuntu" {
  ami                    = var.ami
  instance_type          = var.instance-type
  vpc_security_group_ids = [var.atlas-sg-id]
  subnet_id              = var.subnet-1
  user_data              = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo echo this is $HOSTNAME >> /var/www/html/index.html
        EOF

  tags = {
    Name = "R53-websever"
  }
}