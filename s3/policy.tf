resource "aws_s3_bucket_policy" "cloudtrail-test-kufu" {
    bucket = "cloudtrail-test-kufu"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheck20150319",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::cloudtrail-test-kufu"
    },
    {
      "Sid": "AWSCloudTrailWrite20150319",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::cloudtrail-test-kufu/AWSLogs/736134917012/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "smarthr-api-lp" {
    bucket = "smarthr-api-lp"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::smarthr-api-lp/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "yknot-staging" {
    bucket = "yknot-staging"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::yknot-staging/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "kokeshi-elb-logs" {
    bucket = "kokeshi-elb-logs"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "AWSConsole-AccessLogs-Policy-1492738217415",
  "Statement": [
    {
      "Sid": "AWSConsoleStmt-1492738217415",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::kokeshi-elb-logs/AWSLogs/736134917012/*"
    }
  ]
}
POLICY
}
