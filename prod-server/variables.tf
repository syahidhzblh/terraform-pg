variable "region" {
  default = "ap-southeast-2"
}

locals {
  prod-tag = {
    Name    = "prod-server-0"
    Service = "Web Server"
    Owner   = "DevOps Team"
  }
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "keypair" {
  default = "server-keypair"
}
