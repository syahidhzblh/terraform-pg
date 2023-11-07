provider "aws" {
  region = var.region
}

variable "istest" {
  default = true
}

resource "aws_instance" "dev" {
  ami           = var.ami["ubuntu"]
  instance_type = "t2.micro"
  count         = var.istest == true ? 2 : 1

  tags = {
    Name = "ubuntu-dev.${count.index}"
  }
}

resource "aws_instance" "prod" {
  ami           = var.ami["unix"]
  instance_type = "t2.micro"
  count         = var.istest == false ? 1 : 0

  tags = {
    Name = "ubuntu-prod.${count.index}"
  }
}


#Formula 

#condition ? true_val : false_val
