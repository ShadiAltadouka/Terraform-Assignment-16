variable "s3" {
  description = "s3 bucket name: s3-tf-bucket"
  type        = string
  default     = "s3-tf-bucket-1"

}

variable "kms" {
  description = "KMS encryption type"
  type        = string
  default     = "aws:kms"

}

variable "bootstrap-script" {
  description = "Script for setting up webpage on instance."
  type        = string
  default     = "#!/bin/bash"

}

variable "ubuntu_ami" {
  description = "ami for ubuntu instance"
  type        = string

}

variable "instance_type" {
  description = "instance type for ubuntu instance"
  type        = string

}

variable "key_name" {
  description = "key pair for ubuntu instance"
  type        = string

}

variable "availability_zone" {
  description = "AZ for ubuntu instance"
  type        = string

}