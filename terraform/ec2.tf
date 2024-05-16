data "template_file" "user-data-script" {
  template = file("/home/ec2-user/Terraform-Assignment-16/terraform/scripts/http-webpage-script.sh")

}

resource "aws_instance" "ec2-ubuntu" {
  ami                         = "ami-0e001c9271cf7f3b9"
  availability_zone           = "us-east-1b"
  instance_type               = "t2.micro"
  key_name                    = "terraform"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.atlas-sg.id]
  user_data                   = data.template_file.user-data-script.rendered
  subnet_id                   = aws_subnet.pub-subnet.id

  depends_on = [aws_security_group.atlas-sg]

  tags = {
    Name = "terraform-webserver"
    iac  = "terraform"
  }
}