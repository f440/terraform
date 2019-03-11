resource "aws_iam_group" "kufu-admin" {
  name = "kufu-admin"
  path = "/"
}

resource "aws_iam_group" "kufu-cloudwatch-readonly" {
  name = "kufu-cloudwatch-readonly"
  path = "/"
}

resource "aws_iam_group" "kufu-s3" {
  name = "kufu-s3"
  path = "/"
}

resource "aws_iam_group" "ReadOnly" {
  name = "ReadOnly"
  path = "/"
}
