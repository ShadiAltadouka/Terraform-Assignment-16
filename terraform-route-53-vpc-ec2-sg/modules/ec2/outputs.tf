output "ami" {
    value = aws_instance.ec2-ubuntu.ami
  
}

output "instance-type" {
    value = aws_instance.ec2-ubuntu.instance_type
  
}

output "private-ip" {
    value = aws_instance.ec2-ubuntu.private_ip
  
}