resource "aws_network_acl" "atlas-nacl" {
  vpc_id = aws_vpc.atlas-vpc.id

  tags = {
    Name = "atlas-nacl"
  }

}

resource "aws_network_acl_rule" "nacl-ssh" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 80
  to_port        = 80
  cidr_block     = aws_vpc.atlas-vpc.cidr_block

}

resource "aws_network_acl_rule" "nacl-https" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  rule_number    = 201
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 443
  to_port        = 443
  cidr_block     = aws_vpc.atlas-vpc.cidr_block

}

resource "aws_network_acl_rule" "nacl-nfs" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  rule_number    = 202
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 2049
  to_port        = 2049
  cidr_block     = aws_vpc.atlas-vpc.cidr_block

}