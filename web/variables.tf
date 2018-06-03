variable "region" {
  description = "AWS region"
}

variable "key_name" {
  description = "AWS key pair to use for resources."
}

variable "ami" {
  type = "map"
  description = "A map of AMIs"
  default = {}
}

variable "instance_type" {
  description = "instance type."
  default = "t2.micro"
}
