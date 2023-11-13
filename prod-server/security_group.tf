variable "prod-port" {
  type    = list(any)
  default = [80, 443, 22, 2222]
}

resource "aws_security_group" "prod_sg_0" {
  name        = "web-server"
  description = "Allow Web Server Port for Production"
  vpc_id      = "vpc-004c8b743b19ade7f"

  dynamic "ingress" {
    for_each = var.prod-port
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow Access Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.prod-tag
}
