
resource "aws_db_parameter_group" "hanica-dbparamgroup-1b4u7fzreb186" {
  name   = "hanica-dbparamgroup-1b4u7fzreb186"
  family = "mysql5.6"
  description = "Default parameter group for Portnoy"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "skip-character-set-client-handshake"
    value = "1"
  }

}

resource "aws_db_parameter_group" "hanica-dbparamgroup-20161222" {
  name   = "hanica-dbparamgroup-20161222"
  family = "mysql5.6"
  description = "utf8mb4"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "innodb_file_format"
    value = "Barracuda"
  }

  parameter {
    name  = "innodb_large_prefix"
    value = "1"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "1073741824"
  }

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {
    name  = "skip-character-set-client-handshake"
    value = "1"
  }

  parameter {
    name  = "wait_timeout"
    value = "10800"
  }

}

resource "aws_db_parameter_group" "hanica-dbparamgroup-20170509" {
  name   = "hanica-dbparamgroup-20170509"
  family = "mysql5.7"
  description = "for mysql 5.7"

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "query_cache_size"
    value = "0"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "104857600"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "performance_schema"
    value = "1"
  }

}

resource "aws_db_parameter_group" "yknot-dbparamgroup-1dyv9fxio3ler" {
  name   = "yknot-dbparamgroup-1dyv9fxio3ler"
  family = "mysql5.6"
  description = "Default parameter group for Portnoy"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "skip-character-set-client-handshake"
    value = "1"
  }

}
