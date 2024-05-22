output "vpc-id" {
    value = aws_vpc.atlas-vpc.id
  
}

output "subnet-1" {
    value = aws_subnet.pub-subnet.id
  
}

output "subnet-2" {
    value = aws_subnet.pub-subnet.id
  
}
output "igw" {
    value = aws_internet_gateway.igw-1.id
  
}