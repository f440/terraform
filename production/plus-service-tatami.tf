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
  repository = aws_ecr_repository.tatami-base.name

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
  repository = aws_ecr_repository.tatami-one-off.name

  policy = file("./files/iam/policies/tatami_aws_ecr_repository_policy_tatami_one_off.json")
}

##################################################
#
# IAM
#
##################################################

resource "aws_iam_role" "tatami-operator" {
  name               = "TatamiOperator"
  assume_role_policy = file("./files/iam/roles/account-assume.json")
}

resource "aws_iam_role_policy_attachment" "tatami-operator-ecs-full-access" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "tatami-operator-read-only-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "tatami-run-one-off-task-policy" {
  name = "TatamiRunOneOffTask"
  path = "/"

  policy = file("./files/iam/policies/tatami-run-one-off-task-policy.json")
}

resource "aws_iam_policy" "tatami-manage-parameter-store-parameters-policy" {
  name = "TatamiManageParameterStoreParameters"
  path = "/"

  policy = file(
    "./files/iam/policies/tatami-manage-parameter-store-parameters-policy.json",
  )
}

resource "aws_iam_role_policy_attachment" "tatami-operator-tatami-manage-parameter-store-parameters-policy-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = aws_iam_policy.tatami-manage-parameter-store-parameters-policy.arn
}

resource "aws_iam_policy" "tatami-manage-ecr-repository-policy" {
  name   = "TatamiManageECRRepository"
  path   = "/"
  policy = file("./files/iam/policies/tatami-manage-ecr-repository-policy.json")
}

resource "aws_iam_role_policy_attachment" "tatami-operator-tatami-manage-ecr-repository-policy-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = aws_iam_policy.tatami-manage-ecr-repository-policy.arn
}

resource "aws_iam_policy" "tatami-manage-elasticache-policy" {
  name   = "TatamiManageElastiCache"
  path   = "/"
  policy = file("./files/iam/policies/tatami-manage-elasticache-policy.json")
}

resource "aws_iam_role_policy_attachment" "tatami-operator-tatami-manage-elasticache-policy-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = aws_iam_policy.tatami-manage-elasticache-policy.arn
}

resource "aws_iam_policy" "tatami-manage-rds-policy" {
  name   = "TatamiManageRDS"
  path   = "/"
  policy = file("./files/iam/policies/tatami-manage-rds-policy.json")
}

resource "aws_iam_role_policy_attachment" "tatami-operator-tatami-manage-rds-policy-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = aws_iam_policy.tatami-manage-rds-policy.arn
}

resource "aws_iam_role_policy_attachment" "tatami-operator-elb-full-access-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
}

resource "aws_iam_role" "tatami-production-ecs-task-execution-role" {
  name               = "TatamiProductionEcsTaskExecutionRole"
  description        = "Allows ECS tasks to call AWS services on your behalf."
  assume_role_policy = file("./files/iam/roles/ecs-assume.json")
}

resource "aws_iam_role_policy_attachment" "tatami-production-ecs-task-execution-role-ecs-task-execution-role-attachment" {
  role       = aws_iam_role.tatami-production-ecs-task-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "tatami-ssm-get-parameters-policy" {
  name   = "TatamiSsmGetParameters"
  path   = "/"
  policy = file("./files/iam/policies/tatami-ssm-get-parameters-policy.json")
}

resource "aws_iam_role_policy_attachment" "tatami-production-ecs-task-execution-role-tatami-ssm-get-parameters-policy-attachment" {
  role       = aws_iam_role.tatami-production-ecs-task-execution-role.name
  policy_arn = aws_iam_policy.tatami-ssm-get-parameters-policy.arn
}

resource "aws_iam_policy" "tatami-ecs-update-service-policy" {
  name   = "TatamiEcsUpdateService"
  path   = "/"
  policy = file("./files/iam/policies/tatami-ecs-update-service-policy.json")
}
