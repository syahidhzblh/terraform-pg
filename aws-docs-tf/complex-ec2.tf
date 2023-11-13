provider "aws" {
  region = var.region
}

locals {
  prod_server = {
    Name    = "prod-server-0"
    Service = "Web Server"
    Owner   = "Devops Team"
  }
}

# Attachment Arguments #
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2-attach-eip.id
  allocation_id = aws_eip.lb.id
}

resource "aws_volume_attachment" "ebs" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.ec2-attach-eip.id
  volume_id   = aws_ebs_volume.ubuntu-storage.id
}
# End of Attachment Arguments #

resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "web-server"
  description = "Allow port for default Web Server"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH for Instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.prod_server
}

#Instance Argument
resource "aws_ebs_volume" "ubuntu-storage" {
  availability_zone = "ap-southeast-2a"
  size              = 8

  tags = {
    Name = "ubuntu-volume"
  }
}

resource "aws_instance" "ec2-attach-eip" {
  ami                    = var.ami["ubuntu"]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = var.keypair

  tags = local.prod_server
}


#Output Value
output "public_ip" {
  value = aws_eip.lb.public_ip
}

output "instance_public_ip" {
  value = aws_instance.ec2-attach-eip.public_ip
}

output "vpc_security_group_ids" {
  value = aws_security_group.allow_tls.id
}

output "instance_security_group" {
  value = aws_instance.ec2-attach-eip.security_groups
}

