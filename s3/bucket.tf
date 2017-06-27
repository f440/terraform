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
