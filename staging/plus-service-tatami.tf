##################################################
#
# ElastiCache
#
##################################################
resource "aws_security_group" "tatami-staging-redis-sg" {
  name   = "tatami-staging-redis-sg"
  vpc_id = aws_vpc.staging-hanica-vpc.id

  ingress {
    from_port   = 6379
    protocol    = "tcp"
    to_port     = 6379
    cidr_blocks = [aws_vpc.staging-hanica-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-staging-redis-sg"
  }
}

resource "aws_elasticache_parameter_group" "tatami-staging-redis-50" {
  name        = "tatami-staging-redis-50"
  family      = "redis5.0"
  description = "Redis 5.0 parameter group for tatami staging"
}

resource "aws_elasticache_subnet_group" "tatami-staging-redis-sg" {
  name = "tatami-staging-redis-subnet-group"
  subnet_ids = [
    aws_subnet.tatami-staging-internal-1a.id,
    aws_subnet.tatami-staging-internal-1c.id,
  ]
}

resource "aws_elasticache_replication_group" "plus-tatami-staging" {
  replication_group_id          = "staging-tatami"
  replication_group_description = "Redis instance for tatami-staging"

  number_cache_clusters = 2
  node_type             = "cache.m3.medium"
  engine                = "redis"
  engine_version        = "5.0.6"
  port                  = 6379

  automatic_failover_enabled = true
  auto_minor_version_upgrade = true
  maintenance_window         = "tue:19:00-tue:20:00"
  snapshot_window            = "15:00-16:00"
  snapshot_retention_limit   = "1"

  subnet_group_name    = aws_elasticache_subnet_group.tatami-staging-redis-sg.name
  security_group_ids   = [aws_security_group.tatami-staging-redis-sg.id]
  parameter_group_name = aws_elasticache_parameter_group.tatami-staging-redis-50.name
}

##################################################
#
# RDS
#
##################################################
resource "aws_security_group" "tatami-staging-db-sg" {
  name   = "tatami-staging-db-sg"
  vpc_id = aws_vpc.staging-hanica-vpc.id

  ingress {
    from_port = 5432
    protocol  = "tcp"
    to_port   = 5432
    # TODO:
    # tatami-staging-web, tatami-staging-worker の security groups 作成後に security_groups に置き換える
    cidr_blocks = [aws_vpc.staging-hanica-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tatami-staging-db-sg"
  }
}

resource "aws_db_parameter_group" "tatami-staging-dbparamgroup" {
  name        = "tatami-staging-dbparamgroup"
  family      = "postgres11"
  description = "tatami-staging-dbparamgroup"
}

resource "aws_db_option_group" "tatami-staging-dboptiongroup" {
  name                 = "tatami-staging-dbparamgroup"
  engine_name          = "postgres"
  major_engine_version = "11"
}

resource "aws_db_subnet_group" "tatami-staging-db-subnet-group" {
  name = "tatami-staging-db-subnet-group"
  subnet_ids = [
    aws_subnet.tatami-staging-internal-1a.id,
    aws_subnet.tatami-staging-internal-1c.id,
  ]
}

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
//resource "aws_subnet" "tatami-external-1a" {
//  vpc_id            = aws_vpc.staging-hanica-vpc.id
//  availability_zone = "ap-northeast-1a"
//  cidr_block        = "10.0.34.0/24"
//  tags = {
//    Name = "tatami-external-1a"
//  }
//}
//
//resource "aws_subnet" "tatami-external-1c" {
//  vpc_id            = aws_vpc.staging-hanica-vpc.id
//  availability_zone = "ap-northeast-1c"
//  cidr_block        = "10.0.35.0/24"
//  tags = {
//    Name = "tatami-external-1c"
//  }
//}

resource "aws_subnet" "tatami-staging-internal-1a" {
  vpc_id            = aws_vpc.staging-hanica-vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.36.0/24"
  tags = {
    Name = "staging-tatami-internal-1a"
  }
}

resource "aws_subnet" "tatami-staging-internal-1c" {
  vpc_id            = aws_vpc.staging-hanica-vpc.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.37.0/24"
  tags = {
    Name = "staging-tatami-internal-1c"
  }
}

resource "aws_route_table" "tatami-staging-internal-rt" {
  vpc_id = aws_vpc.staging-hanica-vpc.id

  //  route {
  //    cidr_block     = "0.0.0.0/0"
  //    nat_gateway_id = aws_nat_gateway.tatami-staging-natgw-a.id
  //  }

  tags = {
    Name = "staging-tatami-internal-rt"
  }
}

//resource "aws_route_table" "tatami-staging-external-rt" {
//  vpc_id = aws_vpc.staging-hanica-vpc.id
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
//resource "aws_nat_gateway" "tatami-staging-natgw-1a" {
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

##################################################
#
# S3
#
##################################################

resource "aws_s3_bucket" "tatami-staging-deploy-config" {
  bucket = "tatami-staging-deploy-config"
  acl    = "private"
  region = "ap-northeast-1"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "tatami-staging-deploy-config" {
  bucket                  = aws_s3_bucket.tatami-staging-deploy-config.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "tatami-staging-alb-access-logs" {
  bucket = "tatami-staging-alb-access-logs"
  acl    = "private"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket_public_access_block" "tatami-staging-alb-access-logs" {
  bucket                  = aws_s3_bucket.tatami-staging-alb-access-logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "tatami-staging-blob" {
  bucket = "tatami-staging-blob"
  acl    = "private"
  region = "ap-northeast-1"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "tatami-staging-blob" {
  bucket                  = aws_s3_bucket.tatami-staging-blob.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##################################################
#
# IAM
#
##################################################

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

resource "aws_iam_user" "plus-service-tatami-circleci" {
  name          = "plus-service-tatami-circleci"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-tatami-circleci" {
  name   = "TatamiCircleCI"
  policy = file("./files/iam/policies/plus-service-tatami-circleci.json")
}

resource "aws_iam_policy_attachment" "plus-service-tatami-circleci" {
  name       = "plus-service-tatami-circleci"
  users      = [aws_iam_user.plus-service-tatami-circleci.name]
  policy_arn = aws_iam_policy.plus-service-tatami-circleci.arn
}
