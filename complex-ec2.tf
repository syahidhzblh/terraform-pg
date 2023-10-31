provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2-attach-eip.id
  allocation_id = aws_eip.lb.id
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

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

  tags = {
    Name = "allow_tls"
  }
}

#Instance Argument
resource "aws_instance" "ec2-attach-eip" {
  ami                    = var.ami_ubuntu
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "server-keypair"

  user_data = <<-EOF
  #!/bin/bash
  apt update -y && apt upgrade -y
  apt install -y nginx
  systemctl start nginx
  apt install git
  apt install php-cli php-xml php-curl php-zip php-mbstring php-dom php8.1-mysql
  apt install mariadb-server
  curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
  apt install node-js
  EOF

  tags = {
    Name = "ubuntu-terraform-eip"
  }
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
