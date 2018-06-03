variable "region" {
  description = "THE AWS region."
  default = "ap-northeast-1"
}

variable "ami" {
  type = "map"
  description = "The AMIs to use."
  default = {
    "ap-northeast-1" = "ami-2724cf58"
    "us-west-1" = "ami07c4b331c"
  }
}

variable "security_group_ids" {
  type = "list"
  description = "List of security group IDs"
  default = ["sg-9742f9ef", "sg-9742f9ef", "sg-9742f9ef"]
}
