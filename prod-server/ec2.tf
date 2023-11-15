resource "aws_instance" "prod_server_0" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.prod-keypair.key_name
  vpc_security_group_ids = [aws_security_group.prod_sg_0.id]
  subnet_id              = var.subnet_prod.id

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
    apt install -y git
    apt install -y php-cli php-xml php-curl php-zip php-mbstring php-dom php8.1-mysql
    apt install -y mariadb-server
    curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
    apt install -y node-js
  EOF

  tags = local.prod-tag

  lifecycle {
    ignore_changes = [tags, key_name]
  }
}


