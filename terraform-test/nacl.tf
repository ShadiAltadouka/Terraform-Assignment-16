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
  from_port      = 22
  to_port        = 22
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

resource "aws_network_acl_rule" "nacl-all-outbound" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  rule_number    = 203
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65353
  cidr_block     = "0.0.0.0/0"

}

resource "aws_network_acl_rule" "nacl-all-inbound" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  rule_number    = 204
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65353
  cidr_block     = "0.0.0.0/0"

}