output "aws_security_group" {
  value       = aws_security_group.atlas-sg.id
  description = "Security Group ID of atlas-sg"

}

output "public-DNS" {
  value       = aws_instance.ec2-ubuntu.public_dns
  description = "Public DNS of Ubuntu instance"

}

output "public-ip" {
  value       = aws_instance.ec2-ubuntu.public_ip
  description = "Public IP of Ubuntu instance"

}