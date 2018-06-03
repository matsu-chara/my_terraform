provider "aws" {
  region = "ap-northeast-1"
  version = "~> 1.21"
}

resource "aws_instance" "base" {
  ami = "ami-2724cf58"
  instance_type = "t2.micro"
}
