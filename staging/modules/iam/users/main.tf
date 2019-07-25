## variables
variable "name" {}

## resources
resource "aws_iam_user" "user" {
  name          = "${var.name}"
  force_destroy = true
}

## outputs
output "name" {
  value = "${aws_iam_user.user.name}"
}
