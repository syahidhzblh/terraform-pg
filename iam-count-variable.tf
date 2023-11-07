provider "aws" {
  region = var.region
}

variable "iam-developer" {
  type    = list(any)
  default = ["frontend-dev", "backend-dev", "fullstack-dev"]
}

resource "aws_iam_user" "developer" {
  name  = var.iam-developer[count.index]
  count = 3
  path  = "/system/"
}
