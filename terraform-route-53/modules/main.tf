// VPC
resource "aws_vpc" "atlas-vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "atlas-vpc"
  }
}

// PUBLIC SUBNETS 1 & 2
resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.atlas-vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}
resource "aws_subnet" "pub-subnet-2" {
  vpc_id                  = aws_vpc.atlas-vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

// INTERNET GATEWAY
resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.atlas-vpc.id

  tags = {
    Name = "atlas-igw"
  }
}

// ROUTE TABLE
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.atlas-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-1.id
  }

  tags = {
    Name = "public-route-table"
  }

}

// ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "pub-route" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-route-table.id

}
resource "aws_route_table_association" "pub-route-2" {
  subnet_id      = aws_subnet.pub-subnet-2.id
  route_table_id = aws_route_table.pub-route-table.id

}

// SECURITY GROUPS
resource "aws_security_group" "atlas-sg" {
  name        = "atlas-SG"
  description = "Allow SSH, HTTP, and HTTPS connection."
  vpc_id      = aws_vpc.atlas-vpc.id

  ingress {
    description = "Inbound rule for SSH"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  ingress {
    description = "Inbound rule for HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  ingress {
    description = "Inbound rule for HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }
  egress {
    description = "Outbound rule for ALL traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

// ROUTE-53 HOSTED PRIVATE ZONE
resource "aws_route53_zone" "private-zone" {
  name          = "atlas.local"
  force_destroy = true

  vpc {
    vpc_id = aws_vpc.atlas-vpc.id
  }

  depends_on = [aws_vpc.atlas-vpc]
}

// ROUTE-53 RECORDS
resource "aws_route53_record" "www" {
  name    = "atlas.local"
  type    = "A"
  zone_id = aws_route53_zone.private-zone.id
  records = [aws_instance.ec2-ubuntu.private_ip]
  ttl     = 300

  depends_on = [aws_instance.ec2-ubuntu]

}

// EC2
resource "aws_instance" "ec2-ubuntu" {
  ami                    = "ami-0e001c9271cf7f3b9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.atlas-sg.id]
  subnet_id              = aws_subnet.pub-subnet.id
  user_data              = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo echo this is $HOSTNAME >> /var/www/html/index.html
        EOF

  depends_on = [aws_security_group.atlas-sg]

  tags = {
    Name = "R53-websever"
  }
}