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
  group = aws_iam_group.plus-app.name

  users = [
    "plus-service-oke-circleci",
    aws_iam_user.plus-service-jougo.name,
    aws_iam_user.plus-service-omen.name,
    aws_iam_user.plus-service-tatami-circleci.name,
    "plus-service-auto-maintenance-tool",
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

resource "aws_iam_policy" "plus-service-jougo" {
  name   = "PlusServiceJougoPolicy"
  policy = file("./files/iam/policies/plus-service-jougo.json")
}

resource "aws_iam_policy_attachment" "plus-service-jougo" {
  name       = "plus-service-jougo"
  users      = [aws_iam_user.plus-service-jougo.name]
  policy_arn = aws_iam_policy.plus-service-jougo.arn
}

resource "aws_iam_user" "plus-service-omen" {
  name          = "plus-service-omen"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-omen" {
  name   = "PlusServiceOmenPolicy"
  policy = file("./files/iam/policies/plus-service-omen.json")
}

resource "aws_iam_policy_attachment" "plus-service-omen" {
  name       = "plus-service-omen"
  users      = [aws_iam_user.plus-service-omen.name]
  policy_arn = aws_iam_policy.plus-service-omen.arn
}

resource "aws_iam_user" "plus-service-tatami" {
  name          = "plus-service-tatami"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-tatami" {
  name   = "PlusServicetatamiPolicy"
  policy = file("./files/iam/policies/plus-service-tatami.json")
}

resource "aws_iam_policy_attachment" "plus-service-tatami" {
  name       = "plus-service-tatami"
  users      = [aws_iam_user.plus-service-tatami.name]
  policy_arn = aws_iam_policy.plus-service-tatami.arn
}
