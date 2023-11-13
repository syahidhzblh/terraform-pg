provider "aws" {
  region = var.region
}

resource "aws_iam_user" "developer" {
  name  = "developer.${count.index}"
  count = 3
  path  = "/system/"
}

# output "arn" {
#   value = aws_iam_user.developer[*].arn
# }

# output "iam_name" {
#   value = aws_iam_user.developer[*].name
# }

output "combine" {
  value = zipmap(aws_iam_user.developer[*].name, aws_iam_user.developer[*].arn)
}
