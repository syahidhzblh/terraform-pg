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
    ignore_changes = [tags] //Will be ignored any changes tags in real instance

    //It can be specified with "all" if you want to ignored all changes in real cloud environment
  }
}
