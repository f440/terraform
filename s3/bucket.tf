resource "aws_s3_bucket" "cloudtrail-test-kufu" {
    bucket = "cloudtrail-test-kufu"
    acl = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "smarthr-api-lp" {
    bucket = "smarthr-api-lp"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "kokeshi-space" {
    bucket = "kokeshi.space"
    acl    = "private"
    force_destroy = ""

    website {
      index_document = "index.html"
    }
}

resource "aws_s3_bucket" "yknot-staging" {
    bucket = "yknot-staging"
    acl    = "private"
    force_destroy = ""
}
