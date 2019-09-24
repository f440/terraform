##################################################
#
# ECS
#
##################################################
resource "aws_ecr_repository" "zafu" {
  name = "zafu"
}

resource "aws_ecs_cluster" "zafu-cluster" {
  name = "zafu-cluster"
}

resource "aws_ecs_task_definition" "zafu-users-task-definition" {
  family                = "zafu-users"
  container_definitions = "${file("files/ecs/task-definitions/zafu-users-task.json")}"

  task_role_arn      = "${aws_iam_role.zafu-task-role.arn}"
  execution_role_arn = "${aws_iam_role.zafu-task-execution-role.arn}"

  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "4096"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "zafu-users-service" {
  name                               = "zafu-users"
  task_definition                    = "${aws_ecs_task_definition.zafu-users-task-definition.arn}"
  desired_count                      = 1
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  cluster                            = "${aws_ecs_cluster.zafu-cluster.id}"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"

  network_configuration {
    subnets = [
      "${var.vpc_subnet_hanica_internal_1a_id}",
      "${var.vpc_subnet_hanica_internal_1c_id}",
    ]

    assign_public_ip = "false"
  }
}

resource "aws_ecs_task_definition" "zafu-organizations-task-definition" {
  family                = "zafu-organizations"
  container_definitions = "${file("files/ecs/task-definitions/zafu-organizations-task.json")}"

  task_role_arn      = "${aws_iam_role.zafu-task-role.arn}"
  execution_role_arn = "${aws_iam_role.zafu-task-execution-role.arn}"

  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "4096"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "zafu-organizations-service" {
  name                               = "zafu-organizations"
  task_definition                    = "${aws_ecs_task_definition.zafu-organizations-task-definition.arn}"
  desired_count                      = 1
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  cluster                            = "${aws_ecs_cluster.zafu-cluster.id}"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"

  network_configuration {
    subnets = [
      "${var.vpc_subnet_hanica_internal_1a_id}",
      "${var.vpc_subnet_hanica_internal_1c_id}",
    ]

    assign_public_ip = "false"
  }
}

##################################################
#
# CloudWatch
#
##################################################
# 旧実行ログで監査対応として残している
resource "aws_cloudwatch_log_group" "zafu-batch" {
  name = "zafu"
}

resource "aws_cloudwatch_log_group" "zafu-users" {
  name = "zafu-users"
}

resource "aws_cloudwatch_log_group" "zafu-organizations" {
  name = "zafu-organizations"
}

##################################################
#
# IAM
#
##################################################
### container(fargate) role
resource "aws_iam_role" "zafu-task-role" {
  name               = "ZafuTaskRole"
  assume_role_policy = "${file("./files/iam/roles/ecs-assume.json")}"
}

resource "aws_iam_policy_attachment" "zafu-task-role-policy-attachment" {
  name       = "zafu-task-role-policy-attachment"
  roles      = ["${aws_iam_role.zafu-task-role.name}"]
  policy_arn = "${aws_iam_policy.zafu-task-policy.arn}"
}

resource "aws_iam_policy" "zafu-task-policy" {
  name        = "ZafuTaskPolicy"
  path        = "/"
  description = "ZafuTaskPolicy"
  policy      = "${file("./files/iam/policies/zafu-task-policy.json")}"
}

### container(fargate) execution role
resource "aws_iam_role" "zafu-task-execution-role" {
  name               = "ZafuTaskExecutionRole"
  assume_role_policy = "${file("./files/iam/roles/ecs-assume.json")}"
}

resource "aws_iam_policy_attachment" "zafu-task-execution-role-policy-attachment" {
  name       = "zafu-task-execution-role-policy-attachment"
  roles      = ["${aws_iam_role.zafu-task-execution-role.name}"]
  policy_arn = "${aws_iam_policy.zafu-task-execution-policy.arn}"
}

resource "aws_iam_policy" "zafu-task-execution-policy" {
  name        = "ZafuTaskExecutionPolicy"
  path        = "/"
  description = "ZafuTaskExecutionPolicy"
  policy      = "${file("./files/iam/policies/zafu-task-execution-policy.json")}"
}

### credential(kms)
resource "aws_kms_key" "zafu" {
  description = "ZafuCredentials."
  policy      = "${file("./files/kms/policies/zafu-policy.json")}"

  tags = {
    Name = "zafu"
  }
}

resource "aws_kms_alias" "zafu" {
  name          = "alias/zafu"
  target_key_id = "${aws_kms_key.zafu.key_id}"
}

### circleci(IAMユーザー)
resource "aws_iam_policy" "external-zafu-circleci-policy" {
  name        = "ExternalZafuCircleCIPolicy"
  path        = "/"
  description = "ExternalZafuCircleCIPolicy"
  policy = "${file("./files/iam/policies/external-zafu-circleci-policy.json")}"
}

resource "aws_iam_user" "external-zafu-circleci" {
  name          = "external-zafu-circleci"
  force_destroy = "false"

}

resource "aws_iam_user_policy_attachment" "external-zafu-circleci" {
  user       = "${aws_iam_user.external-zafu-circleci.name}"
  policy_arn = "${aws_iam_policy.external-zafu-circleci-policy.arn}"
}

resource "aws_iam_group" "circleci" {
  name = "circleci"
}

resource "aws_iam_group_membership" "circleci" {
  name  = "circleci"
  group = "${aws_iam_group.circleci.name}"

  users = [
    "${aws_iam_user.external-zafu-circleci.name}",
  ]
}
