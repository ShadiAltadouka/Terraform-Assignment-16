resource "aws_security_group" "atlas-sg-2" {
  name        = var.sg-name
  description = "Allow SSG, HTTP, and HTTPS connection."
  vpc_id      = var.vpc

}

resource "aws_vpc_security_group_ingress_rule" "vpc-ingress-ssh" {
    security_group_id = aws_security_group.atlas-sg-2.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 20
    to_port = 20

}

resource "aws_vpc_security_group_ingress_rule" "vpc-ingress-http" {
    security_group_id = aws_security_group.atlas-sg-2.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80

}

resource "aws_vpc_security_group_ingress_rule" "vpc-ingress-https" {
    security_group_id = aws_security_group.atlas-sg-2.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443

}

resource "aws_vpc_security_group_egress_rule" "vpc-egress-all" {
    security_group_id = aws_security_group.atlas-sg-2.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "all"
    from_port = 0
    to_port = 65353

}