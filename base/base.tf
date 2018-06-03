provider "aws" {
  region  = "${var.region}"
  version = "~> 1.21"
}

resource "aws_instance" "base" {
  ami           = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
}

resource "aws_eip" "base" {
  instance = "${aws_instance.base.id}"
  vpc = true
}
