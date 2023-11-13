provider "aws" {
  region = var.region
}

resource "aws_instance" "for-each-instance" {
  ami = var.ami["ubuntu"]
  for_each = {
    "prod-key-1" = "t2.micro"
    "prod-key-2" = "t2.small"
  }
  instance_type = each.value
  key_name      = each.key

  tags = {
    Name = each.key
  }
}
