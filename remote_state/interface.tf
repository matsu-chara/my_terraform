variable "region" {
  description = "AWS region"
}

variable "prefix" {
  default = "examplecom"
  description = "name of our org"
}

variable "environment" {
  default = "development"
  description = "name of our env"
}
