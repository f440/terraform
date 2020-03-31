##################################################
#
# ECS / ECR
#
##################################################

resource "aws_ecs_cluster" "tatami-production" {
  name = "tatmai-production"
}

resource "aws_ecr_repository" "tatami" {
  name = "tatami"
}

resource "aws_ecr_repository_policy" "tatami" {
  repository = aws_ecr_repository.tatami.name

  policy = file("./files/iam/policies/tatami_aws_ecr_repository_policy_tatami.json")
}

resource "aws_ecr_repository" "tatami-base" {
  name = "tatami/base"
}

resource "aws_ecr_repository_policy" "tatami-base" {
  repository = aws_ecr_repository.tatami.name

  policy = file("./files/iam/policies/tatami_aws_ecr_repository_policy_tatami_base.json")
}


resource "aws_ecr_repository" "tatami-fluentd" {
  name = "tatami/fluentd"
}

resource "aws_ecr_repository_policy" "tatami-fluentd" {
  repository = aws_ecr_repository.tatami-fluentd.name

  policy = file("./files/iam/policies/tatami_aws_ecr_repository_policy_tatami_fluentd.json")
}

resource "aws_ecr_repository" "tatami-one-off" {
  name = "tatami/one-off"
}

resource "aws_ecr_repository_policy" "tatami-one-off" {
  repository = aws_ecr_repository.tatami-base.name

  policy = file("./files/iam/policies/tatami_aws_ecr_repository_policy_tatami_one_off.json")
}
