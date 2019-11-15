resource "aws_elasticache_parameter_group" "oke-redis-40" {
  name        = "oke-redis-40"
  family      = "redis4.0"
  description = "Redis 4.0 parameter group for oke"
}
