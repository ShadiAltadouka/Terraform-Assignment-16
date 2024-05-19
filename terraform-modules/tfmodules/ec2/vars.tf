variable "ami" {
    description = "ami of instance"
    type = string
    default = "ami-0e001c9271cf7f3b9"
  
}

variable "itype" {
    description = "instance type"
    type = string
    default = "t2.micro"
  
}

variable "az" {
    description = "availability zone of instance"
    type = string
    default = "us-east-1a"
  
}

variable "instancename" {
    description = "name of the instance"
    type = string
  
}

variable "vpcsg" {
    description = "vpc security group"
    type = string
}