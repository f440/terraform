# ElastiCache
resource "aws_elasticache_replication_group" "plus-jougo-production" {
  replication_group_id          = "jougo-production"
  replication_group_description = "Redis instance for jougo"

  number_cache_clusters      = 2
  node_type                  = "cache.m3.medium"
  automatic_failover_enabled = true
  auto_minor_version_upgrade = true
  engine                     = "redis"
  engine_version             = "5.0.5"
  port                       = 6379

  availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1c",
  ]

  # Memo
  # 将来的には「aws_elasticache_subnet_group」リソースで作成したものに入れ替えたい
  subnet_group_name = var.plus_subnet_group_name

  # Memo
  # 将来的には「aws_security_group」リソースで作成したものに入れ替えたい
  security_group_ids = [
    var.sg-heroku-ps-redis,
    var.sg-default,
  ]

  parameter_group_name = aws_elasticache_parameter_group.plus-jougo-redis-50.name

  maintenance_window       = "mon:14:30-mon:15:30"
  snapshot_window          = "18:00-19:00"
  snapshot_retention_limit = "1"
}

resource "aws_elasticache_parameter_group" "plus-jougo-redis-50" {
  name        = "jougo-redis-50"
  family      = "redis5.0"
  description = "Redis 5.0 parameter group for jougo"
}

# RDS
resource "aws_db_parameter_group" "jougo-dbparamgroup" {
  name   = "jougo-dbparamgroup"
  family = "postgres11"

  description = "PostgreSQL 11 Parameter Groups for jougo"
}

# IAM
resource "aws_iam_policy" "plus-service-jougo" {
  name   = "PlusServiceJougoPolicy"
  policy = file("./files/iam/policies/plus-service-jougo.json")
}

resource "aws_iam_user" "plus-service-jougo" {
  name          = "plus-service-jougo"
  force_destroy = "false"
}

resource "aws_iam_policy_attachment" "plus-service-jougo" {
  name       = "plus-service-jougo"
  users      = [aws_iam_user.plus-service-jougo.name]
  policy_arn = aws_iam_policy.plus-service-jougo.arn
}

resource "aws_iam_group" "plus-app" {
  name = "plus-app"
}

resource "aws_iam_group_membership" "plus-app" {
  name  = "plus-app"
  group = aws_iam_group.plus-app.name

  users = [
    aws_iam_user.plus-service-jougo.name,
  ]
}

