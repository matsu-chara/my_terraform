provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source        = "./vpc"
  name          = "web"
  cidr          = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  ami                         = "${lookup(var.ami, var.region)}}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}}"
  subnet_id                   = "${module.vpc.public_subnet_id}"
  associate_public_ip_address = true
  user_data                   = "${file("files/web_bootstrap.sh")}}"

  vpc_security_group_ids = [
    "${aws_security_group.web_host_sg.id}",
  ]

  count      = "${length(var.instance_ips)}"
  private_ip = "${var.instance_ips[count.index]}"

  tags {
    Name = "web-${format("%03d", count.index+1)}"
  }
}

resource "aws_elb" "web" {
  name            = "web-elb"
  subnets         = ["${module.vpc.public_subnet_id}"]
  security_groups = ["${aws_security_group.web_inbound_sg.id}"]

  "listener" {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  instances = ["${aws_instance.web.*.id}"]
}

resource "aws_security_group" "web_inbound_sg" {
  name        = "web_inbound"
  description = "Allow HTTP from Anywhere"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    protocol    = "icmp"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_host_sg" {
  name        = "web_host"
  description = "Allow SSH * HTTP to web hosts"
  vpc_id      = "${module.vpc.vpc_id}}"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    protocol    = "icmp"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["${module.vpc.cidr}"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
