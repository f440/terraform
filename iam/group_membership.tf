resource "aws_iam_group_membership" "kufu-admin" {
    name  = "kufu-admin-group-membership"
    users = ["kanzaki", "fujii", "naito", "takahashi", "yoshinari", "serverless", "hanica-circleci", "mizoue", "serizawa", "inoue", "tansu-admin", "tei", "miyaguni", "iida"]
    group = "kufu-admin"
}

resource "aws_iam_group_membership" "kufu-cloudwatch-readonly" {
    name  = "kufu-cloudwatch-readonly-group-membership"
    users = ["cloudwatch"]
    group = "kufu-cloudwatch-readonly"
}

resource "aws_iam_group_membership" "kufu-s3" {
    name  = "kufu-s3-group-membership"
    users = ["embulk-analysis"]
    group = "kufu-s3"
}

resource "aws_iam_group_membership" "ReadOnly" {
    name  = "ReadOnly-group-membership"
    users = ["read-only-user"]
    group = "ReadOnly"
}
