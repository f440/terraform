//##################################################
//#
//# ElastiCache
//#
//##################################################
//resource "aws_elasticache_replication_group" "plus-tatami-staging" {
//  replication_group_id          = "tatami-staging"
//  replication_group_description = "Redis instance for tatami-staging"
//
//  number_cache_clusters      = 2
//  node_type                  = "cache.m3.medium"
//  automatic_failover_enabled = true
//  auto_minor_version_upgrade = true
//  engine                     = "redis"
//  engine_version             = "4.0.10"
//  port                       = 6379
//
//  # Memo
//  # 将来的には「aws_elasticache_subnet_group」リソースで作成したものに入れ替えたい
//  subnet_group_name = var.plus_subnet_group_name
//
//  # Memo
//  # 将来的には「aws_security_group」リソースで作成したものに入れ替えたい
//  security_group_ids = [
//    var.sg-heroku-ps-redis,
//    var.sg-default,
//  ]
//
//  parameter_group_name = aws_elasticache_parameter_group.tatami-redis-40.name
//
//  maintenance_window       = "tue:19:00-tue:20:00"
//  snapshot_window          = "15:00-16:00"
//  snapshot_retention_limit = "1"
//}
//
//resource "aws_elasticache_parameter_group" "tatami-redis-40" {
//  name        = "tatami-redis-40"
//  family      = "redis4.0"
//  description = "Redis 4.0 parameter group for tatami"
//}
//
//##################################################
//#
//# RDS
//#
//##################################################
//
//resource "aws_db_parameter_group" "tatami-dbparamgroup" {
//  name        = "tatami-dbparamgroup"
//  family      = "postgres10"
//  description = "tatami-dbparamgroup"
//}
//
//##################################################
//#
//# VPC
//#
//##################################################
//resource "aws_subnet" "tatami-external-1a" {
//  vpc_id            = var.vpc-hanica-new-vpc
//  availability_zone = "ap-northeast-1a"
//  cidr_block        = "10.0.30.0/24"
//  tags = {
//    Name = "tatami-external-1a"
//  }
//}
//
//resource "aws_subnet" "tatami-external-1c" {
//  vpc_id            = var.vpc-hanica-new-vpc
//  availability_zone = "ap-northeast-1c"
//  cidr_block        = "10.0.31.0/24"
//  tags = {
//    Name = "tatami-external-1c"
//  }
//}
//
//resource "aws_subnet" "tatami-internal-1a" {
//  vpc_id            = var.vpc-hanica-new-vpc
//  availability_zone = "ap-northeast-1a"
//  cidr_block        = "10.0.32.0/24"
//  tags = {
//    Name = "tatami-internal-1a"
//  }
//}
//
//resource "aws_subnet" "tatami-internal-1c" {
//  vpc_id            = var.vpc-hanica-new-vpc
//  availability_zone = "ap-northeast-1c"
//  cidr_block        = "10.0.33.0/24"
//  tags = {
//    Name = "tatami-internal-1c"
//  }
//}
//
//resource "aws_route_table" "tatami-internal-rt" {
//  vpc_id = var.vpc-hanica-new-vpc
//
//  route {
//    cidr_block     = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.tatami-natgw-a.id
//  }
//
//  tags = {
//    Name = "tatami-internal-rt"
//  }
//}
//
//resource "aws_route_table" "tatami-external-rt" {
//  vpc_id = var.vpc-hanica-new-vpc
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = var.hanica-new-igw
//  }
//
//  tags = {
//    Name = "tatami-external-rt"
//  }
//}
//
//resource "aws_nat_gateway" "tatami-natgw-a" {
//  allocation_id = aws_eip.tatami-natgw.id
//  subnet_id     = aws_subnet.tatami-external-1a.id
//
//  tags = {
//    Name = "tatami-natgw-a"
//  }
//}
//
//resource "aws_eip" "tatami-natgw" {
//  tags = {
//    Name = "tatami-natgw"
//  }
//}
//
//##################################################
//#
//# ECS / ECR
//#
//##################################################
//
//resource "aws_ecs_cluster" "tatami-staging" {
//  name = "tatami-staging"
//}
//
//resource "aws_ecr_repository" "tatami" {
//  name = "tatami"
//}
//
//##################################################
//#
//# IAM
//#
//##################################################
//
//resource "aws_iam_role" "tatami-operator" {
//  name               = "OkeOperator"
//  assume_role_policy = file("./files/iam/roles/account-assume.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-ecs-full-access" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-read-only-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
//}
//
//resource "aws_iam_policy" "tatami-run-one-off-task-policy" {
//  name = "OkeRunOneOffTask"
//  path = "/"
//
//  policy = file("./files/iam/policies/tatami-run-one-off-task-policy.json")
//}
//
//resource "aws_iam_policy" "tatami-manage-parameter-store-parameters-policy" {
//  name = "OkeManageParameterStoreParameters"
//  path = "/"
//
//  policy = file(
//    "./files/iam/policies/tatami-manage-parameter-store-parameters-policy.json",
//  )
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-oke-manage-parameter-store-parameters-policy-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = aws_iam_policy.tatami-manage-parameter-store-parameters-policy.arn
//}
//
//resource "aws_iam_policy" "tatami-manage-ecr-repository-policy" {
//  name   = "OkeManageECRRepository"
//  path   = "/"
//  policy = file("./files/iam/policies/tatami-manage-ecr-repository-policy.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-oke-manage-ecr-repository-policy-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = aws_iam_policy.tatami-manage-ecr-repository-policy.arn
//}
//
//resource "aws_iam_policy" "tatami-manage-elasticache-policy" {
//  name   = "OkeManageElastiCache"
//  path   = "/"
//  policy = file("./files/iam/policies/tatami-manage-elasticache-policy.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-oke-manage-elasticache-policy-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = aws_iam_policy.tatami-manage-elasticache-policy.arn
//}
//
//resource "aws_iam_policy" "tatami-manage-rds-policy" {
//  name   = "OkeManageRDS"
//  path   = "/"
//  policy = file("./files/iam/policies/tatami-manage-rds-policy.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-oke-manage-rds-policy-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = aws_iam_policy.tatami-manage-rds-policy.arn
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-operator-elb-full-access-attachment" {
//  role       = aws_iam_role.tatami-operator.name
//  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
//}
//
//resource "aws_iam_role" "tatami-staging-ecs-task-execution-role" {
//  name               = "OkeProductionEcsTaskExecutionRole"
//  description        = "Allows ECS tasks to call AWS services on your behalf."
//  assume_role_policy = file("./files/iam/roles/ecs-assume.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-staging-ecs-task-execution-role-ecs-task-execution-role-attachment" {
//  role       = aws_iam_role.tatami-staging-ecs-task-execution-role.name
//  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
//}
//
//resource "aws_iam_policy" "tatami-ssm-get-parameters-policy" {
//  name   = "OkeSsmGetParameters"
//  path   = "/"
//  policy = file("./files/iam/policies/tatami-ssm-get-parameters-policy.json")
//}
//
//resource "aws_iam_role_policy_attachment" "tatami-staging-ecs-task-execution-role-tatami-ssm-get-parameters-policy-attachment" {
//  role       = aws_iam_role.tatami-staging-ecs-task-execution-role.name
//  policy_arn = aws_iam_policy.tatami-ssm-get-parameters-policy.arn
//}
//
//resource "aws_iam_policy" "tatami-ecs-update-service-policy" {
//  name   = "OkeEcsUpdateService"
//  path   = "/"
//  policy = file("./files/iam/policies/tatami-ecs-update-service-policy.json")
//}
//
//resource "aws_iam_role" "codebuild-tatami-staging-database-migration-service-role" {
//  name               = "codebuild-tatamiProductionDatabaseMigration-service-role"
//  path               = "/service-role/"
//  assume_role_policy = file("./files/iam/roles/codebuild-assume.json")
//}
//
//resource "aws_iam_policy" "tatami-codebuild-base-tatami-staging-database-migration-policy" {
//  name        = "CodeBuildBasePolicy-tatamiProductionDatabaseMigration-ap-northeast-1"
//  description = "Policy used in trust relationship with CodeBuild"
//  path        = "/service-role/"
//  policy = file(
//    "./files/iam/policies/tatami-codebuild-base-policy-database-migration.json",
//  )
//}
//
//resource "aws_iam_role_policy_attachment" "codebuild-tatami-staging-database-migration-service-role-tatami-ssm-get-parameters-policy-attachment" {
//  role       = aws_iam_role.codebuild-tatami-staging-database-migration-service-role.name
//  policy_arn = aws_iam_policy.tatami-ssm-get-parameters-policy.arn
//}
//
//resource "aws_iam_role_policy_attachment" "codebuild-tatami-staging-database-migration-service-role-tatami-codebuild-base-oke-production-database-migration-policy-attachment" {
//  role       = aws_iam_role.codebuild-tatami-staging-database-migration-service-role.name
//  policy_arn = aws_iam_policy.tatami-codebuild-base-tatami-staging-database-migration-policy.arn
//}
//
//resource "aws_iam_role_policy_attachment" "codebuild-tatami-staging-database-migration-service-role-tatami-ecs-update-service-policy-attachment" {
//  role       = aws_iam_role.codebuild-tatami-staging-database-migration-service-role.name
//  policy_arn = aws_iam_policy.tatami-ecs-update-service-policy.arn
//}
//
//resource "aws_iam_policy" "tatami-codebuild-base-tatami-staging-deploy-worker-policy" {
//  name        = "CodeBuildBasePolicy-tatamiProductionDeployWorker-ap-northeast-1"
//  description = "Policy used in trust relationship with CodeBuild"
//  path        = "/service-role/"
//  policy = file(
//    "./files/iam/policies/tatami-codebuild-base-policy-deploy-worker.json",
//  )
//}
//
//resource "aws_iam_role" "codebuild-tatami-staging-deploy-worker-service-role" {
//  name               = "codebuild-tatamiProductionDeployWorker-service-role"
//  path               = "/service-role/"
//  assume_role_policy = file("./files/iam/roles/codebuild-assume.json")
//}
//
//resource "aws_iam_role_policy_attachment" "codebuild-tatami-staging-deploy-worker-service-role-tatami-codebuild-base-oke-production-deploy-worker-policy-attachment" {
//  role       = aws_iam_role.codebuild-tatami-staging-deploy-worker-service-role.name
//  policy_arn = aws_iam_policy.tatami-codebuild-base-tatami-staging-deploy-worker-policy.arn
//}
//
//resource "aws_iam_role_policy_attachment" "codebuild-tatami-staging-deploy-worker-service-role-tatami-ecs-update-service-policy-attachment" {
//  role       = aws_iam_role.codebuild-tatami-staging-deploy-worker-service-role.name
//  policy_arn = aws_iam_policy.tatami-ecs-update-service-policy.arn
//}
//
