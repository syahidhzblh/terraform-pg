provider "aws" {
  region = var.region
}

resource "aws_instance" "lifecycle-instance" {
  ami           = var.ami["ubuntu"]
  instance_type = "t2.micro"
  key_name      = var.keypair

  tags = {
    Name = "lifecycle-instance"
  }

  lifecycle {
    //This argument for protect any important configuration, so it (resource) can not be destroyed. as long as this configuration still exists
    prevent_destroy = true
  }
}
