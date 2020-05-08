##################################################
#
# IAM
#
##################################################
resource "aws_iam_user" "plus-service-koban" {
  name          = "plus-service-koban"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-koban" {
  name   = "PlusServiceKobanPolicy"
  policy = file("./files/iam/policies/plus-service-koban.json")
}

resource "aws_iam_policy_attachment" "plus-service-koban" {
  name       = "plus-service-koban"
  users      = [aws_iam_user.plus-service-koban.name]
  policy_arn = aws_iam_policy.plus-service-koban.arn
}

##################################################
#
# S3
#
##################################################
resource "aws_s3_bucket" "koban-development" {
  bucket = "koban-development"
  acl    = "private"
  region = "ap-northeast-1"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "koban-development" {
  bucket                  = aws_s3_bucket.koban-development.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
resource "aws_s3_bucket_policy" "koban-development-policy" {
  bucket = aws_s3_bucket.koban-development.id
  policy = file("./files/s3/policies/koban-development-policy.json")
}
*/
