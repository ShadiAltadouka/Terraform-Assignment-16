resource "aws_security_group" "atlas-sg" {
  name        = "atlas-SG"
  description = "Allow SSH, HTTP, and HTTPS connection."
  vpc_id      = var.atlas-vpc

  ingress {
    description = "Inbound rule for SSH"
    cidr_blocks = [var.all-cidr]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  ingress {
    description = "Inbound rule for HTTP"
    cidr_blocks = [var.all-cidr]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  ingress {
    description = "Inbound rule for HTTPS"
    cidr_blocks = [var.all-cidr]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }
  egress {
    description = "Outbound rule for ALL traffic"
    cidr_blocks = [var.all-cidr]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}