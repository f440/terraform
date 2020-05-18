##################################################
#
# VPC
#
# - external
#   - 10.0.34.0/24
#   - 10.0.35.0/24
# - internal
#   - 10.0.36.0/24
#   - 10.0.37.0/24
#
##################################################
resource "aws_subnet" "tatami-production-external-1a" {
  vpc_id            = var.vpc-hanica-new-vpc
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.34.0/24"
  tags = {
    Name = "tatami-production-external-1a"
  }
}

resource "aws_subnet" "tatami-production-external-1c" {
  vpc_id            = var.vpc-hanica-new-vpc
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.35.0/24"
  tags = {
    Name = "tatami-production-external-1c"
  }
}

resource "aws_subnet" "tatami-production-internal-1a" {
  vpc_id            = var.vpc-hanica-new-vpc
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.36.0/24"
  tags = {
    Name = "production-tatami-internal-1a"
  }
}

resource "aws_subnet" "tatami-production-internal-1c" {
  vpc_id            = var.vpc-hanica-new-vpc
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.37.0/24"
  tags = {
    Name = "production-tatami-internal-1c"
  }
}

resource "aws_route_table" "tatami-production-internal-rt-1a" {
  vpc_id = var.vpc-hanica-new-vpc

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.hanica-ngw-1a
  }

  tags = {
    Name = "production-tatami-internal-rt"
  }
}

resource "aws_route_table_association" "tatami-production-internal-rt-1a" {
  subnet_id      = aws_subnet.tatami-production-internal-1a.id
  route_table_id = aws_route_table.tatami-production-internal-rt-1a.id
}

resource "aws_route_table" "tatami-production-internal-rt-1c" {
  vpc_id = var.vpc-hanica-new-vpc

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.hanica-ngw-1c
  }

  tags = {
    Name = "production-tatami-internal-rt"
  }
}

resource "aws_route_table_association" "tatami-production-internal-rt-1c" {
  subnet_id      = aws_subnet.tatami-production-internal-1c.id
  route_table_id = aws_route_table.tatami-production-internal-rt-1c.id
}

resource "aws_route_table" "tatami-production-external-rt" {
  vpc_id = var.vpc-hanica-new-vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.hanica-new-igw
  }

  tags = {
    Name = "tatami-external-rt"
  }
}

resource "aws_route_table_association" "tatami-production-external-rt-1a" {
  subnet_id      = aws_subnet.tatami-production-external-1a.id
  route_table_id = aws_route_table.tatami-production-external-rt.id
}

resource "aws_route_table_association" "tatami-production-external-rt-1c" {
  subnet_id      = aws_subnet.tatami-production-external-1c.id
  route_table_id = aws_route_table.tatami-production-external-rt.id
}


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

resource "aws_iam_role_policy_attachment" "tatami-operator-tatami-run-one-off-task-policy-attachment" {
  role       = aws_iam_role.tatami-operator.name
  policy_arn = aws_iam_policy.tatami-run-one-off-task-policy.arn
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

resource "aws_iam_role" "codebuild-tatami-production-database-migration-service-role" {
  name               = "codebuild-tatamiProductionDatabaseMigration-service-role"
  path               = "/service-role/"
  assume_role_policy = file("./files/iam/roles/codebuild-assume.json")
}

resource "aws_iam_policy" "tatami-codebuild-base-tatami-production-database-migration-policy" {
  name        = "CodeBuildBasePolicy-tatamiProductionDatabaseMigration-ap-northeast-1"
  description = "Policy used in trust relationship with CodeBuild"
  path        = "/service-role/"
  policy = file(
    "./files/iam/policies/tatami-codebuild-base-policy-database-migration.json",
  )
}

resource "aws_iam_role_policy_attachment" "codebuild-tatami-production-database-migration-service-role-tatami-ssm-get-parameters-policy-attachment" {
  role       = aws_iam_role.codebuild-tatami-production-database-migration-service-role.name
  policy_arn = aws_iam_policy.tatami-ssm-get-parameters-policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild-tatami-production-database-migration-service-role-tatami-codebuild-base-tatami-production-database-migration-policy-attachment" {
  role       = aws_iam_role.codebuild-tatami-production-database-migration-service-role.name
  policy_arn = aws_iam_policy.tatami-codebuild-base-tatami-production-database-migration-policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild-tatami-production-database-migration-service-role-tatami-ecs-update-service-policy-attachment" {
  role       = aws_iam_role.codebuild-tatami-production-database-migration-service-role.name
  policy_arn = aws_iam_policy.tatami-ecs-update-service-policy.arn
}

resource "aws_iam_policy" "tatami-codebuild-base-tatami-production-deploy-worker-policy" {
  name        = "CodeBuildBasePolicy-tatamiProductionDeployWorker-ap-northeast-1"
  description = "Policy used in trust relationship with CodeBuild"
  path        = "/service-role/"
  policy = file(
    "./files/iam/policies/tatami-codebuild-base-policy-deploy-worker.json",
  )
}

resource "aws_iam_role" "codebuild-tatami-production-deploy-worker-service-role" {
  name               = "codebuild-tatamiProductionDeployWorker-service-role"
  path               = "/service-role/"
  assume_role_policy = file("./files/iam/roles/codebuild-assume.json")
}

resource "aws_iam_role_policy_attachment" "codebuild-tatami-production-deploy-worker-service-role-tatami-codebuild-base-tatami-production-deploy-worker-policy-attachment" {
  role       = aws_iam_role.codebuild-tatami-production-deploy-worker-service-role.name
  policy_arn = aws_iam_policy.tatami-codebuild-base-tatami-production-deploy-worker-policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild-tatami-production-deploy-worker-service-role-tatami-ecs-update-service-policy-attachment" {
  role       = aws_iam_role.codebuild-tatami-production-deploy-worker-service-role.name
  policy_arn = aws_iam_policy.tatami-ecs-update-service-policy.arn
}

##################################################
#
# ElastiCache
#
##################################################
resource "aws_security_group" "tatami-production-redis-sg" {
  name   = "tatami-production-redis-sg"
  vpc_id = var.vpc-hanica-new-vpc

  ingress {
    from_port = 6379
    protocol  = "tcp"
    to_port   = 6379
    security_groups = [
      aws_security_group.tatami-production-web-sg.id,
      aws_security_group.tatami-production-worker-sg.id,
    ]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-production-redis-sg"
  }
}

##################################################
#
# EC2
#
##################################################

resource "aws_security_group" "tatami-production-alb-sg" {
  name   = "tatami-production-alb-sg"
  vpc_id = var.vpc-hanica-new-vpc

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-production-alb-sg"
  }
}

##################################################
#
# Web / Worker
#
##################################################

resource "aws_security_group" "tatami-production-web-sg" {
  name   = "tatami-production-web-sg"
  vpc_id = var.vpc-hanica-new-vpc

  ingress {
    from_port       = 3000
    protocol        = "tcp"
    to_port         = 3000
    security_groups = [aws_security_group.tatami-production-alb-sg.id]
  }

  tags = {
    Name = "tatami-production-web-sg"
  }
}

resource "aws_security_group_rule" "tatami-production-web-sg-http-rule" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tatami-production-web-sg.id
}

resource "aws_security_group_rule" "tatami-production-web-sg-https-ipv4-rule" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tatami-production-web-sg.id
}

resource "aws_security_group_rule" "tatami-production-web-sg-https-ipv6-rule" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tatami-production-web-sg.id
}


resource "aws_security_group_rule" "tatami-production-web-sg-papertrail-rule" {
  type              = "egress"
  from_port         = 18124
  to_port           = 18124
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tatami-production-web-sg.id
}

resource "aws_security_group_rule" "tatami-production-web-sg-redis-rule" {
  type                     = "egress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tatami-production-redis-sg.id
  security_group_id        = aws_security_group.tatami-production-web-sg.id
}

resource "aws_security_group_rule" "tatami-production-web-sg-db-rule" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tatami-production-db-sg.id
  security_group_id        = aws_security_group.tatami-production-web-sg.id
}

resource "aws_security_group" "tatami-production-worker-sg" {
  name   = "tatami-production-worker-sg"
  vpc_id = var.vpc-hanica-new-vpc

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-production-worker-sg"
  }
}

##################################################
#
# RDS
#
##################################################
resource "aws_security_group" "tatami-production-db-sg" {
  name   = "tatami-production-db-sg"
  vpc_id = var.vpc-hanica-new-vpc

  ingress {
    from_port = 5432
    protocol  = "tcp"
    to_port   = 5432
    security_groups = [
      aws_security_group.tatami-production-web-sg.id,
      aws_security_group.tatami-production-worker-sg.id,
    ]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-production-db-sg"
  }
}

