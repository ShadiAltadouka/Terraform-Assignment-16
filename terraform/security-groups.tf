resource "aws_security_group" "atlas-sg" {
  name        = "atlas-SG"
  description = "Allow SSH, HTTPS, and NFS connection."
  vpc_id      = aws_vpc.atlas-vpc.id

  tags = {
    Name = "atlas-SG"
  }

}

resource "aws_security_group_rule" "sg-ssh" {
  security_group_id = aws_security_group.atlas-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "sg-https" {
  security_group_id = aws_security_group.atlas-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "sg-nfs" {
  security_group_id = aws_security_group.atlas-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 2049
  to_port           = 2049
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "sg-all-inbound" {
  security_group_id = aws_security_group.atlas-sg.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65353
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "sg-all-outbound" {
  security_group_id = aws_security_group.atlas-sg.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65353
  cidr_blocks       = ["0.0.0.0/0"]

}