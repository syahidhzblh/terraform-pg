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
    create_before_destroy = true   //If any changes, it will create new instance first before destroy old instance
    ignore_changes        = [tags] //Will be ignored any changes tags in real instance
  }
}
