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

resource "aws_db_parameter_group" "oke-dbparamgroup" {
  name   = "oke-dbparamgroup"
  family = "postgres10"
  description = "oke-dbparamgroup"
}
