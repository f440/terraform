##################################################
#
# ElastiCache
#
##################################################
resource "aws_elasticache_replication_group" "plus-oke-production" {
  replication_group_id          = "oke-production"
  replication_group_description = "Redis instance for oke-production"

  number_cache_clusters      = 2
  node_type                  = "cache.m3.medium"
  automatic_failover_enabled = true
  auto_minor_version_upgrade = true
  engine                     = "redis"
  engine_version             = "4.0.10"
  port                       = 6379

  # Memo
  # 将来的には「aws_elasticache_subnet_group」リソースで作成したものに入れ替えたい
  subnet_group_name = "${var.plus_subnet_group_name}"

  # Memo
  # 将来的には「aws_security_group」リソースで作成したものに入れ替えたい
  security_group_ids = [
    "${var.sg-heroku-ps-redis}",
    "${var.sg-default}",
  ]

  parameter_group_name = "${aws_elasticache_parameter_group.oke-redis-40.name}"

  maintenance_window       = "tue:19:00-tue:20:00"
  snapshot_window          = "15:00-16:00"
  snapshot_retention_limit = "1"
}

resource "aws_elasticache_parameter_group" "oke-redis-40" {
  name        = "oke-redis-40"
  family      = "redis4.0"
  description = "Redis 4.0 parameter group for oke"
}

##################################################
#
# RDS
#
##################################################

resource "aws_db_parameter_group" "oke-dbparamgroup" {
  name        = "oke-dbparamgroup"
  family      = "postgres10"
  description = "oke-dbparamgroup"
}

##################################################
#
# VPC
#
##################################################
resource "aws_subnet" "oke-external-1a" {
  vpc_id            = "${var.vpc-hanica-new-vpc}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.30.0/24"
  tags = {
    Name = "oke-external-1a"
  }
}

resource "aws_subnet" "oke-external-1c" {
  vpc_id            = "${var.vpc-hanica-new-vpc}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.31.0/24"
  tags = {
    Name = "oke-external-1c"
  }
}

resource "aws_subnet" "oke-internal-1a" {
  vpc_id            = "${var.vpc-hanica-new-vpc}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.32.0/24"
  tags = {
    Name = "oke-internal-1a"
  }
}

resource "aws_subnet" "oke-internal-1c" {
  vpc_id            = "${var.vpc-hanica-new-vpc}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.33.0/24"
  tags = {
    Name = "oke-internal-1c"
  }
}

resource "aws_route_table" "oke-internal-rt" {
  vpc_id = "${var.vpc-hanica-new-vpc}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.oke-natgw-a.id}"
  }

  tags = {
    Name = "oke-internal-rt"
  }
}

resource "aws_route_table" "oke-external-rt" {
  vpc_id = "${var.vpc-hanica-new-vpc}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.hanica-new-igw}"
  }

  tags = {
    Name = "oke-external-rt"
  }
}

resource "aws_nat_gateway" "oke-natgw-a" {
  allocation_id = "${aws_eip.oke-natgw.id}"
  subnet_id     = "${aws_subnet.oke-external-1a.id}"

  tags = {
    Name = "oke-natgw-a"
  }
}

resource "aws_eip" "oke-natgw" {
  tags = {
    Name = "oke-natgw"
  }
}

##################################################
#
# ECS / ECR
#
##################################################

resource "aws_ecs_cluster" "oke-production" {
  name = "oke-production"
}

resource "aws_ecr_repository" "oke" {
  name = "oke"
}

##################################################
#
# IAM
#
##################################################

resource "aws_iam_role" "oke-operator" {
  name               = "OkeOperator"
  assume_role_policy = "${file("./files/iam/roles/account-assume.json")}"
}

resource "aws_iam_role_policy_attachment" "oke-operator-ecs-full-access" {
  role       = "${aws_iam_role.oke-operator.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "oke-operator-read-only-attachment" {
  role       = "${aws_iam_role.oke-operator.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "oke-run-one-off-task-policy" {
  name = "OkeRunOneOffTask"
  path = "/"

  policy = "${file("./files/iam/policies/oke-run-one-off-task-policy.json")}"
}

resource "aws_iam_policy" "oke-manage-parameter-store-parameters-policy" {
  name = "OkeManageParameterStoreParameters"
  path = "/"

  policy = "${file("./files/iam/policies/oke-manage-parameter-store-parameters-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "oke-operator-oke-manage-parameter-store-parameters-policy-attachment" {
  role       = "${aws_iam_role.oke-operator.name}"
  policy_arn = "${aws_iam_policy.oke-manage-parameter-store-parameters-policy.arn}"
}

resource "aws_iam_role" "oke-production-ecs-task-execution-role" {
  name               = "OkeProductionEcsTaskExecutionRole"
  description        = "Allows ECS tasks to call AWS services on your behalf."
  assume_role_policy = "${file("./files/iam/roles/ecs-assume.json")}"
}

resource "aws_iam_role_policy_attachment" "oke-production-ecs-task-execution-role-ecs-task-execution-role-attachment" {
  role       = "${aws_iam_role.oke-production-ecs-task-execution-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "oke-ssm-get-parameters-policy" {
  name   = "OkeSsmGetParameters"
  path   = "/"
  policy = "${file("./files/iam/policies/oke-ssm-get-parameters-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "oke-production-ecs-task-execution-role-oke-ssm-get-parameters-policy-attachment" {
  role       = "${aws_iam_role.oke-production-ecs-task-execution-role.name}"
  policy_arn = "${aws_iam_policy.oke-ssm-get-parameters-policy.arn}"
}

resource "aws_iam_policy" "oke-ecs-update-service-policy" {
  name   = "OkeEcsUpdateService"
  path   = "/"
  policy = "${file("./files/iam/policies/oke-ecs-update-service-policy.json")}"
}

resource "aws_iam_role" "codebuild-oke-production-database-migration-service-role" {
  name               = "codebuild-okeProductionDatabaseMigration-service-role"
  path               = "/service-role/"
  assume_role_policy = "${file("./files/iam/roles/codebuild-assume.json")}"
}

resource "aws_iam_policy" "oke-codebuild-base-oke-production-database-migration-policy" {
  name        = "CodeBuildBasePolicy-okeProductionDatabaseMigration-ap-northeast-1"
  description = "Policy used in trust relationship with CodeBuild"
  path        = "/service-role/"
  policy      = "${file("./files/iam/policies/oke-codebuild-base-policy-database-migration.json")}"
}

resource "aws_iam_role_policy_attachment" "codebuild-oke-production-database-migration-service-role-oke-ssm-get-parameters-policy-attachment" {
  role       = "${aws_iam_role.codebuild-oke-production-database-migration-service-role.name}"
  policy_arn = "${aws_iam_policy.oke-ssm-get-parameters-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "codebuild-oke-production-database-migration-service-role-oke-codebuild-base-oke-production-database-migration-policy-attachment" {
  role       = "${aws_iam_role.codebuild-oke-production-database-migration-service-role.name}"
  policy_arn = "${aws_iam_policy.oke-codebuild-base-oke-production-database-migration-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "codebuild-oke-production-database-migration-service-role-oke-ecs-update-service-policy-attachment" {
  role       = "${aws_iam_role.codebuild-oke-production-database-migration-service-role.name}"
  policy_arn = "${aws_iam_policy.oke-ecs-update-service-policy.arn}"
}

resource "aws_iam_policy" "oke-codebuild-base-oke-production-deploy-worker-policy" {
  name        = "CodeBuildBasePolicy-okeProductionDeployWorker-ap-northeast-1"
  description = "Policy used in trust relationship with CodeBuild"
  path        = "/service-role/"
  policy      = "${file("./files/iam/policies/oke-codebuild-base-policy-deploy-worker.json")}"
}

resource "aws_iam_role" "codebuild-oke-production-deploy-worker-service-role" {
  name               = "codebuild-okeProductionDeployWorker-service-role"
  path               = "/service-role/"
  assume_role_policy = "${file("./files/iam/roles/codebuild-assume.json")}"
}

resource "aws_iam_role_policy_attachment" "codebuild-oke-production-deploy-worker-service-role-oke-codebuild-base-oke-production-deploy-worker-policy-attachment" {
  role       = "${aws_iam_role.codebuild-oke-production-deploy-worker-service-role.name}"
  policy_arn = "${aws_iam_policy.oke-codebuild-base-oke-production-deploy-worker-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "codebuild-oke-production-deploy-worker-service-role-oke-ecs-update-service-policy-attachment" {
  role       = "${aws_iam_role.codebuild-oke-production-deploy-worker-service-role.name}"
  policy_arn = "${aws_iam_policy.oke-ecs-update-service-policy.arn}"
}
