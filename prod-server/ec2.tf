resource "aws_instance" "prod-server-0" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.keypair
  vpc_security_group_ids = [aws_security_group.prod-0-sg.id]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
  }

  user_data = <<-EOF
    #!/bin/bash
    apt update -y && apt upgrade -y
    sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
    /etc/init.d/ssh restart
    apt install -y nginx
    systemctl start nginx
    apt install git
    apt install php-cli php-xml php-curl php-zip php-mbstring php-dom php8.1-mysql
    apt install mariadb-server
    curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
    apt install node-js
  EOF

  tags = local.prod-tag
}

output "ec2-public_ip" {
  value = aws_instance.prod-server-0.public_ip
}

output "timestamp" {
  value = local.time
}
