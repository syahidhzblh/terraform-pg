output "ec2-public_ip" {
  value = aws_instance.prod_server_0.public_ip
}

output "sg-name" {
  value = aws_security_group.prod_sg_0.name
}

output "timestamp" {
  value = local.time
}

output "private_key" {
  value     = tls_private_key.prod-ppk.private_key_pem
  sensitive = true
}
