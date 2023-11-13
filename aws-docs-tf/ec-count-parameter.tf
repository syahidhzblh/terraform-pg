provider "aws" {
  region = var.region
}

resource "aws_instance" "instance-count" {
  ami           = var.ami["ubuntu"]
  instance_type = "t2.micro"
  count         = 3

  tags = {
    Name = "ubuntu.${count.index}"
  }
}
