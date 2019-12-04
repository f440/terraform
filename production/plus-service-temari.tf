resource "aws_glue_catalog_database" "temari_glue_catalog_database" {
  name = "temari_production"
}

resource "aws_glue_catalog_table" "temari_glue_catalog_table_for_temari_papertrail_athena" {
  name          = "temari_papertrail_logs"
  database_name = "${aws_glue_catalog_database.temari_glue_catalog_database.name}"

  table_type = "EXTERNAL_TABLE"

  partition_keys {
    name = "dt"
    type = "string"
  }

  parameters = {
    EXTERNAL             = "TRUE"
    "has_encrypted_data" = "false"
  }

  storage_descriptor {
    location      = "s3://temari-papertrail/production"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "xyzzy"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "field.delim"          = "\t"
        "serialization.format" = "\t"
      }
    }

    columns {
      name = "id"
      type = "bigint"
    }

    columns {
      name = "generated_at"
      type = "string"
    }

    columns {
      name = "received_at"
      type = "string"
    }

    columns {
      name = "source_id"
      type = "bigint"
    }

    columns {
      name = "source_name"
      type = "string"
    }

    columns {
      name = "source_ip"
      type = "string"
    }

    columns {
      name = "facility_name"
      type = "string"
    }

    columns {
      name = "severity_name"
      type = "string"
    }

    columns {
      name = "program"
      type = "string"
    }

    columns {
      name = "message"
      type = "string"
    }
  }
}

