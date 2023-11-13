provider "aws" {
  region = var.region-function
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region-function" {
  default = "ap-southeast-2"
}

variable "ami-function" {
  type = map(any)
  default = {
    "ap-southeast-2" = "ami-0df4b2961410d4cff" #ubuntu
    "us-west-2"      = "ami-07b5c2e394fccab6e" #unix
  }
}

variable "tags-function" {
  type    = list(any)
  default = ["frist-ec2", "second-ec2"]
}

resource "aws_instance" "instance-function" {
  ami           = lookup(var.ami-function, var.region-function)
  instance_type = "t2.micro"
  key_name      = var.keypair
  count         = 2

  tags = {
    Name = element(var.tags-function, count.index)
  }
}

output "timestamp" {
  value = local.time
}
