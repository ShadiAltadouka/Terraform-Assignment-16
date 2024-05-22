output "ec2-pub-ip" {
    value = aws_instance.instance1.public_ip
  
}

output "ec2-priv-ip" {
    value = aws_instance.instance1.private_ip
  
}

output "ec2-pub-dns" {
    value = aws_instance.instance1.public_dns
  
}

output "ec2-priv-dns" {
    value = aws_instance.instance1.private_dns
  
}