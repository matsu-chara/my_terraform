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

resource "aws_security_group" "allow_http_ssh" {
  name = "allow_http_ssh"
  description = "allow http/ssh"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "web-server"
    Made = "terraform"
  }
}
