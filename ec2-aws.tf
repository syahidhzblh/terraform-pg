provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "my-ec2" {
  ami                    = "ami-0df4b2961410d4cff" #ubuntu ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0c7efeb67587bf015"] #Use Existing SG in AWS

  tags = {
    Name = "ec2-terraform"
  }
}

