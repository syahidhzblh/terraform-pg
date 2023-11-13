resource "tls_private_key" "prod-ppk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "prod-keypair" {
  key_name   = var.keypair
  public_key = tls_private_key.prod-ppk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename        = "prod-keypair.pem"
  content         = tls_private_key.prod-ppk.private_key_pem
  file_permission = "0400"
}
