resource "aws_iam_role" "administrator" {
  name               = "administrator"
  assume_role_policy = "${file("./files/iam/roles/account-assume.json")}"
}

resource "aws_iam_policy_attachment" "administrator-role-attachment" {
  name       = "administrator-role-attachment"
  roles      = ["${aws_iam_role.administrator.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "developer" {
  name               = "developer"
  assume_role_policy = "${file("./files/iam/roles/account-assume.json")}"
}

resource "aws_iam_policy_attachment" "developer-role-attachment" {
  name       = "developer-role-attachment"
  roles      = ["${aws_iam_role.developer.name}"]
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
