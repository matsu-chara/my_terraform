provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "./vpc"
  name = "web"
  cidr = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "web" {
  ami = "${lookup(var.ami, var.region)}}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}}"
  subnet_id = "${module.vpc.public_subnet_id}"
  associate_public_ip_address = true
  user_data = "${file("files/web_bootstrap.sh")}}"

  vpc_security_group_ids = [
    "${aws_security_group.web_host_sg.id}"
  ]
  count = 2
}

resource "aws_elb" "web" {
  name = "web-elb"
  subnets = ["${module.vpc.public_subnet_id}"]
  security_groups = ["${aws_security_group.web_inbound_sg.id}"]
  "listener" {
    instance_port = 80
    instance_protocol = ""
    lb_port = 0
    lb_protocol = ""
  }
  instances = ["${aws_instance.web.*.id}"]
}

resource "aws_security_group" "web_inbound_sg" {[
]}
