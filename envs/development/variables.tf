variable "region" {
  description = "AWS region"
}

variable "prefix" {
  description = "name of our org"
}

variable "environment" {
  description = "environment"
}

variable "key_name" {
  description = "AWS key pair"
}

variable "vpc_cidr" {
  description = "CIDR"
}

variable "public_subnets" {
  type = "list"
  default = []
  description = "lift of subnet"
}

variable "private_subnets" {} {
  type = "list"
  default = []
  description = "list of private subnet"
}
