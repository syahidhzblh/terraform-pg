provider "aws" {
  region = var.region
}

resource "aws_iam_user" "developer" {
  name  = "developer.${count.index}"
  count = 3
  path  = "/system/"
}
