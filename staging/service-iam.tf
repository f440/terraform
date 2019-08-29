##################################################
#
# Group
#
# * userをgroupに紐づけてIAMユーザーの用途を識別しやすくする
#
##################################################
resource "aws_iam_group" "plus-app" {
  name = "plus-app"
}

resource "aws_iam_group_membership" "plus-app" {
  name  = "plus-app"
  group = "${aws_iam_group.plus-app.name}"

  users = [
    "${aws_iam_user.plus-service-jougo.name}",
  ]
}

##################################################
#
# User
#
# * herokuで使用する際のクレデンシャルでIAMユーザーを作成する
#
##################################################
resource "aws_iam_user" "plus-service-jougo" {
  name          = "plus-service-jougo"
  force_destroy = "false"
}

resource "aws_iam_user_policy" "plus-service-jougo" {
  name   = "PlusServiceJougoPolicy"
  user   = "${aws_iam_user.plus-service-jougo.name}"
  policy = "${file("./files/iam/policies/plus-service-jougo.json")}"
}
