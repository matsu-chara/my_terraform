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
  type        = "map"
  description = "A map of AMIs"

  default = {
    "ap-northeast-1" = "ami-2724cf58"
    "us-west-1"      = "ami07c4b331c"
  }
}

variable "instance_type" {
  description = "instance type."
  default     = "t2.micro"
}

variable "instance_ips" {
  type        = "list"
  description = "IPs to use for our instances"
  default     = ["10.0.1.20", "10.0.1.21"]
}

variable "owner_tag" {
  type = "list"
  default = ["team1", "team2"]
}

variable "environment" {
  default = "development"
}
