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
    aws_iam_user.plus-service-tatami.name,
    aws_iam_user.plus-service-tatami-circleci.name,
    aws_iam_user.plus-service-meyasu.name,
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

resource "aws_iam_user" "plus-service-meyasu" {
  name          = "plus-service-meyasu"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-meyasu" {
  name   = "PlusServicemeyasuPolicy"
  policy = file("./files/iam/policies/plus-service-meyasu.json")
}

resource "aws_iam_policy_attachment" "plus-service-meyasu" {
  name       = "plus-service-meyasu"
  users      = [aws_iam_user.plus-service-meyasu.name]
  policy_arn = aws_iam_policy.plus-service-meyasu.arn
}
