# resource "aws_ebs_volume" "prod-0-volume" {
#   availability_zone = "ap-southeast-2a"
#   size              = 8

#   tags = {
#     Name = "ebs-prod-0"
#   }
# }

# resource "aws_volume_attachment" "prod_volume_attachment" {
#   device_name = "/dev/sda1"
#   instance_id = aws_instance.prod-server-0.id
#   volume_id   = aws_ebs_volume.prod-0-volume.id
# }
