resource "aws_db_instance" "docker-staging" {
    identifier                = "docker-staging"
    allocated_storage         = 300
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.7.16"
    instance_class            = "db.t2.micro"
    name                      = ""
    username                  = "admin"
    password                  = "xxxxxxxx"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "ap-northeast-1a"
    security_group_names      = []
    vpc_security_group_ids    = ["sg-99be0ffc"]
    db_subnet_group_name      = "hanica-dbsubnetgroup-163c09r6dxjsq"
    parameter_group_name      = "default.mysql5.7"
    multi_az                  = false
    backup_retention_period   = 1
    backup_window             = "14:39-15:09"
    maintenance_window        = "sat:20:00-sat:20:30"
    final_snapshot_identifier = "docker-staging-final"

    lifecycle {
      ignore_changes = ["password"]
    }
}
resource "aws_db_instance" "hanica-production-0" {
    identifier                = "hanica-production-0"
    allocated_storage         = 300
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.7.16"
    instance_class            = "db.m4.2xlarge"
    name                      = ""
    username                  = "admin"
    password                  = "xxxxxxxx"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "ap-northeast-1c"
    security_group_names      = []
    vpc_security_group_ids    = ["sg-9ebe0ffb", "sg-99be0ffc"]
    db_subnet_group_name      = "hanica-dbsubnetgroup-163c09r6dxjsq"
    parameter_group_name      = "hanica-dbparamgroup-20170509"
    multi_az                  = true
    backup_retention_period   = 1
    backup_window             = "19:00-21:00"
    maintenance_window        = "sat:16:00-sat:16:30"
    final_snapshot_identifier = "hanica-production-0-final"
    copy_tags_to_snapshot     = true
    monitoring_interval       = 5

    lifecycle {
      ignore_changes = ["password"]
    }

    tags {
        Mackerel = "on"
    }

}

resource "aws_db_instance" "hanica-sandbox" {
    identifier                = "hanica-sandbox"
    allocated_storage         = 5
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.7.16"
    instance_class            = "db.t2.micro"
    name                      = ""
    username                  = "admin"
    password                  = "xxxxxxxx"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "ap-northeast-1a"
    security_group_names      = []
    vpc_security_group_ids    = ["sg-99be0ffc", "sg-9ebe0ffb"]
    db_subnet_group_name      = "hanica-dbsubnetgroup-163c09r6dxjsq"
    parameter_group_name      = "hanica-dbparamgroup-20170509"
    multi_az                  = false
    backup_retention_period   = 7
    backup_window             = "19:00-19:30"
    maintenance_window        = "sat:20:00-sat:20:30"
    final_snapshot_identifier = "hanica-sandbox-final"
    monitoring_interval       = 60

    tags {
        workload-type = "?????"
    }

    lifecycle {
      ignore_changes = ["password"]
    }
}
resource "aws_db_instance" "hanica-staging3" {
    identifier                = "hanica-staging3"
    allocated_storage         = 300
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.7.16"
    instance_class            = "db.t2.micro"
    name                      = ""
    username                  = "admin"
    password                  = "xxxxxxxx"
    port                      = 3306
    publicly_accessible       = false
    availability_zone         = "ap-northeast-1c"
    security_group_names      = []
    vpc_security_group_ids    = ["sg-9ebe0ffb", "sg-99be0ffc"]
    db_subnet_group_name      = "hanica-dbsubnetgroup-163c09r6dxjsq"
    parameter_group_name      = "hanica-dbparamgroup-20170509"
    multi_az                  = false
    backup_retention_period   = 1
    backup_window             = "14:39-15:09"
    maintenance_window        = "sat:20:00-sat:20:30"
    final_snapshot_identifier = "hanica-staging3-final"
    monitoring_interval       = 0

    lifecycle {
      ignore_changes = ["password"]
    }
}
