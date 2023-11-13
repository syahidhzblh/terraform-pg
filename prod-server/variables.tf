# Variable Argument
variable "region" {
  default = "ap-southeast-2"
}

variable "keypair" {
  default = "prod-keypair"
}

# Tag Argument
locals {
  prod-tag = {
    Name       = "prod-server-0"
    Env        = "production"
    Service    = "Web Server"
    Department = "Infra"
    Owner      = "DevOps Team"
  }
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

# Data Argument
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] #Canocial Official

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
