provider "aws" {
 access_key = var.access_key
 secret_key = var.secret_key
 region     = var.region
 # version    = ">= 3.0"
}

resource "aws_instance" "example" {
 ami           = var.ami
 instance_type = var.instanceType
 network_interface {
  network_interface_id = aws_network_interface.my_nic.id
  device_index         = 0
 }
}

resource "aws_network_interface" "my_nic" {
 description = "My NIC"
 subnet_id   = var.subnet
}

variable "access_key" {}
variable "secret_key" {}
variable "region" {}


variable "ami" {
  type        = string
  default     =  "ami-0022f774911c1d690"
  description = "AMI ID for the EC2 instance"
}
 
variable "instanceType" {
  type        = string
  default     =   "m1.small"
  description = "instance type"
}

variable "subnet" {
  type        = string
  description = "Subnet ID for network interface"
  default     = "subnet-282a4575"
}
