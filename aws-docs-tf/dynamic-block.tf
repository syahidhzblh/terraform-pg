provider "aws" {
  region = var.region
}

variable "sg-ports" {
  type        = list(any)
  description = "Port list Web Server"
  default     = [80, 443, 22, 2222]
}

resource "aws_security_group" "sg-dynamic-block" {
  name        = "web-server-dynamic"
  description = "Allow Port Web Server"

  dynamic "ingress" {
    for_each = var.sg-ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

