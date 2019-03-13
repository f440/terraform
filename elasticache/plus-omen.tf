resource "aws_elasticache_replication_group" "plus-omen-production" {
  replication_group_id          = "omen-production"
  replication_group_description = "Redis instance for omen-production"

  number_cache_clusters      = 2
  node_type                  = "cache.m3.medium"
  automatic_failover_enabled = true
  auto_minor_version_upgrade = true
  engine                     = "redis"
  engine_version             = "3.2.10"
  port                       = 6379

  availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1c",
  ]

  # Memo
  # 将来的には「aws_elasticache_subnet_group」リソースで作成したものに入れ替えたい
  subnet_group_name = "${var.plus_subnet_group_name}"

  # Memo
  # 将来的には「aws_security_group」リソースで作成したものに入れ替えたい
  security_group_ids = [
    "${var.sg-heroku-ps-redis}",
    "${var.sg-default}",
  ]

  parameter_group_name = "${aws_elasticache_parameter_group.plus-omen-redis-32.name}"

  maintenance_window       = "mon:14:30-mon:15:30"
  snapshot_window          = "18:00-19:00"
  snapshot_retention_limit = "1"
}

resource "aws_elasticache_parameter_group" "plus-omen-redis-32" {
  name        = "omen-redis-32"
  family      = "redis3.2"
  description = "Redis 3.2 parameter group for omen"
}
