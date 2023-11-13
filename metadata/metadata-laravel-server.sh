#!/bin/bash
apt update -y && apt upgrade -y
apt install -y nginx
systemctl start nginx
apt install -y git
apt install -y php-cli php-xml php-curl php-zip php-mbstring php-dom php8.1-mysql
apt install -y mariadb-server
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
apt install -y node-js

