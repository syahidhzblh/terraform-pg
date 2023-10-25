provider "aws" {
  region     = "ap-southeast-2"
  access_key = "AKIASGNQVGKCXVVDN63O"
  secret_key = "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"
}

resource "aws_instance" "my-ec2" {
  ami                    = "ami-0df4b2961410d4cff" #ubuntu ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0c7efeb67587bf015"] #Use Existing SG in AWS

  tags = {
    Name = "ec2-terraform"
  }
}

