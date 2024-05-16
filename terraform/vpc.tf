resource "aws_vpc" "atlas-vpc" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "atlas-vpc"
  }
}

resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.atlas-vpc.id

  tags = {
    Name = "atlas-igw"
  }
}

resource "aws_nat_gateway" "ngw-1" {
  subnet_id         = aws_subnet.priv-subnet.id
  connectivity_type = "private"

  tags = {
    Name = "atlas-ngw"
  }
}

resource "aws_subnet" "pub-subnet" {
  vpc_id            = aws_vpc.atlas-vpc.id
  cidr_block        = "192.168.0.0/25"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "priv-subnet" {
  vpc_id            = aws_vpc.atlas-vpc.id
  cidr_block        = "192.168.0.128/25"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-1"
  }
}

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

resource "aws_route_table_association" "pub-route" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-route-table.id

}

resource "aws_route_table" "priv-route-table" {
  vpc_id = aws_vpc.atlas-vpc.id

  route {
    cidr_block     = "192.168.2.0/25"
    nat_gateway_id = aws_nat_gateway.ngw-1.id
  }

  tags = {
    Name = "private-route-table"
  }

}

resource "aws_route_table_association" "priv-route" {
  subnet_id      = aws_subnet.priv-subnet.id
  route_table_id = aws_route_table.priv-route-table.id

}

resource "aws_main_route_table_association" "priv-rt-main" {
  vpc_id         = aws_vpc.atlas-vpc.id
  route_table_id = aws_route_table.priv-route-table.id

}

resource "aws_network_acl_association" "nacl-pub-subnets" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  subnet_id      = aws_subnet.pub-subnet.id

}

resource "aws_network_acl_association" "nacl-priv-subnets" {
  network_acl_id = aws_network_acl.atlas-nacl.id
  subnet_id      = aws_subnet.priv-subnet.id
}