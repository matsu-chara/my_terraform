provider "aws" {
  region = "${var.region}"
}

module "remote_state" {
  source = "github.com/turnbullpress/tf_remote_state.git"
  prefix = "${var.prefix}"
  environment = "${var.environment}"
}

module "vpc" {
  source = "github.com/turnbullpress/tf_vpc.git?ref=v0.0.2"
  environment = "${var.environment}"
  region = "${var.region}"
}

