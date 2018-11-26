resource "aws_elasticache_cluster" "ayatori-production" {
  cluster_id = "ayatori-production"

  engine         = "redis"
  engine_version = "3.2.10"
  port           = 6379

  node_type            = "cache.m3.medium"
  num_cache_nodes      = 1
  # TODO: 作成する
  # parameter_group_name = "ayatori-redis-32"
  parameter_group_name = "default.redis3.2"
  # Memo: 将来的には「aws_elasticache_subnet_group」リソースで作成したものに入れ替えたい
  subnet_group_name    = "hanica-docker-redis-subnet-group"
  # Memo: 将来的には「aws_security_group」リソースで作成したものに入れ替えたい
  security_group_ids = [
    "sg-0db4aaa18c4522a07",
    "sg-c97f2baf",
  ]

  maintenance_window = "mon:14:30-mon:15:30"

  preferred_availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
}

resource "aws_elasticache_cluster" "ayatori-production-replica" {
  cluster_id           = "cluster-example"
  replication_group_id = "${aws_elasticache_replication_group.example.id}"
}
