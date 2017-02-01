#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-2b349873
#
# Your security group ID is:
#
#     sg-bcd874db
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     ttt-ant
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami           = "ami-30217250"
  instance_type = "t2.micro"
  subnet_id     = "subnet-2b349873"
  count         = "2"

  vpc_security_group_ids = ["sg-bcd874db"]

  tags {
    Identity = "ttt-ant"
    Name     = "Web"
    Subnet   = "TTT.ant-subnet"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

module "example" {
  source = "./example-module"
  command = "echo ' Goodbye World'"
}
