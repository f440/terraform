resource "aws_elasticache_parameter_group" "persistent-32" {
  name        = "persistent-32"
  family      = "redis3.2"
  description = "Settings for persistent data"

  parameter {
    name  = "repl-backlog-ttl"
    value = "3600"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-seconds"
    value = "60"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-seconds"
    value = "0"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-hard-limit"
    value = "0"
  }

  parameter {
    name  = "slowlog-max-len"
    value = "128"
  }

  parameter {
    name  = "timeout"
    value = "0"
  }

  parameter {
    name  = "list-compress-depth"
    value = "0"
  }

  parameter {
    name  = "zset-max-ziplist-entries"
    value = "128"
  }

  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }

  parameter {
    name  = "databases"
    value = "16"
  }

  parameter {
    name  = "close-on-slave-write"
    value = "yes"
  }

  parameter {
    name  = "repl-backlog-size"
    value = "1048576"
  }

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "min-slaves-max-lag"
    value = "10"
  }

  parameter {
    name  = "set-max-intset-entries"
    value = "512"
  }

  parameter {
    name  = "zset-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-limit"
    value = "8388608"
  }

  parameter {
    name  = "maxmemory-samples"
    value = "3"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-limit"
    value = "0"
  }

  parameter {
    name  = "cluster-enabled"
    value = "no"
  }

  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "hll-sparse-max-bytes"
    value = "3000"
  }

  parameter {
    name  = "slowlog-log-slower-than"
    value = "10000"
  }

  parameter {
    name  = "cluster-require-full-coverage"
    value = "no"
  }

  parameter {
    name  = "min-slaves-to-write"
    value = "0"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-hard-limit"
    value = "33554432"
  }

  parameter {
    name  = "maxmemory-policy"
    value = "noeviction"
  }

  parameter {
    name  = "tcp-keepalive"
    value = "300"
  }

  parameter {
    name  = "reserved-memory"
    value = "0"
  }
}

resource "aws_elasticache_parameter_group" "volatile-32" {
  name        = "volatile-32"
  family      = "redis3.2"
  description = "Settings for volatile data"

  parameter {
    name  = "repl-backlog-ttl"
    value = "3600"
  }

  parameter {
    name  = "reserved-memory"
    value = "0"
  }

  parameter {
    name  = "tcp-keepalive"
    value = "300"
  }

  parameter {
    name  = "maxmemory-policy"
    value = "volatile-lru"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-hard-limit"
    value = "33554432"
  }

  parameter {
    name  = "min-slaves-to-write"
    value = "0"
  }

  parameter {
    name  = "cluster-require-full-coverage"
    value = "no"
  }

  parameter {
    name  = "slowlog-log-slower-than"
    value = "10000"
  }

  parameter {
    name  = "hll-sparse-max-bytes"
    value = "3000"
  }

  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "cluster-enabled"
    value = "no"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-limit"
    value = "0"
  }

  parameter {
    name  = "maxmemory-samples"
    value = "3"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-limit"
    value = "8388608"
  }

  parameter {
    name  = "zset-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "set-max-intset-entries"
    value = "512"
  }

  parameter {
    name  = "min-slaves-max-lag"
    value = "10"
  }

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "repl-backlog-size"
    value = "1048576"
  }

  parameter {
    name  = "close-on-slave-write"
    value = "yes"
  }

  parameter {
    name  = "databases"
    value = "16"
  }

  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }

  parameter {
    name  = "zset-max-ziplist-entries"
    value = "128"
  }

  parameter {
    name  = "list-compress-depth"
    value = "0"
  }

  parameter {
    name  = "timeout"
    value = "0"
  }

  parameter {
    name  = "slowlog-max-len"
    value = "128"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-seconds"
    value = "60"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-seconds"
    value = "0"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-hard-limit"
    value = "0"
  }
}

resource "aws_elasticache_parameter_group" "hanica-redis-50" {
  name        = "hanica-redis-50"
  family      = "redis5.0"
  description = "Redis 5.0 parameter group for hanica"
}

resource "aws_elasticache_parameter_group" "hanica-persistent-redis-50" {
  name        = "hanica-persistent-redis-50"
  family      = "redis5.0"
  description = "Redis 5.0 parameter group for hanica persistent"
}

