variable "expiration-days" {
  default = 30
}

resource "aws_s3_bucket" "hanica-citus-backup" {
  acl           = "private"
  bucket        = "hanica-citus-backup"
  force_destroy = false
  region        = "ap-northeast-1"
  request_payer = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = "true"
  }

  lifecycle_rule {
    id      = "backup-expiration"
    enabled = true

    expiration {
      days = var.expiration-days
    }

    noncurrent_version_expiration {
      days = var.expiration-days
    }
  }
}


