provider "aws" {
  region = var.region
}

resource "aws_iam_user" "developer" {
  for_each = toset(["developer-0", "developer-1", "developer-2", "developer-3"])
  name     = each.key
  path     = "/system/"
}
