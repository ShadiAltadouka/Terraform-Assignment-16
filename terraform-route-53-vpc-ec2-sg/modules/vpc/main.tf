resource "aws_vpc" "atlas-vpc" {
  cidr_block           = var.vpc-network
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "atlas-vpc"
  }
}

resource "aws_subnet" "pub-subnet" {
  vpc_id                  = aws_vpc.atlas-vpc.id
  cidr_block              = var.sub-network-1
  availability_zone       = var.az-a
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}
resource "aws_subnet" "pub-subnet-2" {
  vpc_id                  = aws_vpc.atlas-vpc.id
  cidr_block              = var.sub-network-2
  availability_zone       = var.az-b
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.atlas-vpc.id

  tags = {
    Name = "atlas-igw"
  }
}

resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.atlas-vpc.id

  route {
    cidr_block = var.all-cidr
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
resource "aws_route_table_association" "pub-route-2" {
  subnet_id      = aws_subnet.pub-subnet-2.id
  route_table_id = aws_route_table.pub-route-table.id

}