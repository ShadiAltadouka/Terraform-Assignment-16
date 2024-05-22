variable "az-a" {
    description = ""
    type = string
    default = "us-east-1a"

}

variable "az-b" {
    description = ""
    type = string
    default = "us-east-1b"

}

variable "all-cidr" {
    description = ""
    type = string
    default = "0.0.0.0/0"

}

variable "vpc-network" {
    description = ""
    type = string
    default = "192.168.0.0/16"

}

variable "sub-network-1" {
    description = ""
    type = string
    default = "192.168.1.0/24"

}

variable "sub-network-2" {
    description = ""
    type = string
    default = "192.168.2.0/24"

}