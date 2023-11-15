# Variable Argument
variable "region" {
  default = "ap-southeast-2"
}

variable "keypair" {
  default = "prod-keypair"
}

variable "subnet_prod" {
  default = "subnet-086e050cb1bb60490"
}

variable "vpc_prod" {
  default = "vpc-004c8b743b19ade7f"
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
