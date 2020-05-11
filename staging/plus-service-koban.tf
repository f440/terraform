##################################################
#
# IAM
#
##################################################
resource "aws_iam_user" "plus-service-koban-api-document" {
  name          = "plus-service-koban-api-document"
  force_destroy = "false"
}

resource "aws_iam_policy" "plus-service-koban-api-document" {
  name   = "PlusServiceKobanApiDocumentPolicy"
  policy = file("./files/iam/policies/plus-service-koban-api-document.json")
}

resource "aws_iam_policy_attachment" "plus-service-koban-api-document" {
  name       = "plus-service-koban-api-document"
  users      = [aws_iam_user.plus-service-koban-api-document.name]
  policy_arn = aws_iam_policy.plus-service-koban-api-document.arn
}

##################################################
#
# S3
#
##################################################
resource "aws_s3_bucket" "koban-api-document" {
  bucket = "koban-api-document"
  acl    = "private"
  region = "ap-northeast-1"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "koban-api-document" {
  bucket                  = aws_s3_bucket.koban-api-document.id
  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "koban-api-document-policy" {
  bucket = aws_s3_bucket.koban-api-document.id
  policy = file("./files/s3/policies/koban-api-document-policy.json")
}
