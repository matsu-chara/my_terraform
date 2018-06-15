variable "region" {}

variable "ami" {
  type = "map"
  default = {
    "us-east-1" = "ami-f652979b"
    "us-west-1" = "ami-7c4b331c"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "james"
}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = "list"
}
variable "private_subnet_ids" {
  type = "list"
}
variable "domain" {}
variable "web_instance_count" {}
variable "app_instance_count" {}

output "web_elb_address" {
  value = "${ aws_elb.web.dns_name}"
}
output "web_host_addresses" {
  value = "${ aws_instance.web.*. private_ip}"
}
output "app_host_addresses" {
  value = "${ aws_instance.app.*. private_ip}"
}

