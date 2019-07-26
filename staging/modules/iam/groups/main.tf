## variables

variable "name" {}

variable "users" {
  type = "list"
}

## resources

resource "aws_iam_group" "main" {
  name = "${var.name}"
}

resource "aws_iam_group_membership" "main" {
  name  = "${aws_iam_group.main.name}"
  group = "${aws_iam_group.main.name}"
  users = "${var.users}"
}

resource "aws_iam_group_policy" "main" {
  name   = "${aws_iam_group.main.name}"
  group  = "${aws_iam_group.main.name}"
  policy = "${file("./files/iam/policies/${var.name}.json")}"
}

## outputs

output "name" {
  value = "${aws_iam_group.main.name}"
}
