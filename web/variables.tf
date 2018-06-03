variable "region" {
  description = "AWS region"
}

variable "key_name" {
  description = "AWS key pair to use for resources."
}

variable "public_key_path" {
  description = "AWS key path"
}

variable "ami" {
  type = "map"
  description = "A map of AMIs"
  default = {
    "ap-northeast-1" = "ami-2724cf58"
    "us-west-1" = "ami07c4b331c"
  }
}

variable "instance_type" {
  description = "instance type."
  default = "t2.micro"
}
