resource "aws_s3_bucket" "bak-20170208-smarthr-production" {
    bucket = "bak-20170208-smarthr-production"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "cf-templates-5sy5m8ovfkzr-ap-northeast-1" {
    bucket = "cf-templates-5sy5m8ovfkzr-ap-northeast-1"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "elasticbeanstalk-ap-northeast-1-736134917012" {
    bucket = "elasticbeanstalk-ap-northeast-1-736134917012"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "elasticbeanstalk-ap-northeast-1-736134917012" {
    bucket = "elasticbeanstalk-ap-northeast-1-736134917012"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "eb-ad78f54a-f239-4c90-adda-49e5f56cb51e",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::736134917012:role/aws-elasticbeanstalk-ec2-role"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::elasticbeanstalk-ap-northeast-1-736134917012/resources/environments/logs/*"
    },
    {
      "Sid": "eb-58950a8c-feb6-11e2-89e0-0800277d041b",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "arn:aws:s3:::elasticbeanstalk-ap-northeast-1-736134917012"
    },
    {
      "Sid": "eb-af163bf3-d27b-4712-b795-d1e33e331ca4",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::736134917012:role/aws-elasticbeanstalk-ec2-role",
          "arn:aws:iam::736134917012:role/hanica-PowerUserRole-4XJCF4IP5J8X",
          "arn:aws:iam::736134917012:role/yknot-PowerUserRole-1P04EZ1KTTO8K"
        ]
      },
      "Action": [
        "s3:ListBucketVersions",
        "s3:GetObjectVersion",
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::elasticbeanstalk-ap-northeast-1-736134917012/resources/environments/*",
        "arn:aws:s3:::elasticbeanstalk-ap-northeast-1-736134917012"
      ]
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "cloudtrail-test-kufu" {
    bucket = "cloudtrail-test-kufu"
    acl = "private"
    force_destroy = ""
}

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

resource "aws_s3_bucket" "hanica-logbucket-1ev0czxrupen3" {
    bucket = "hanica-logbucket-1ev0czxrupen3"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "hanica-logbucket-1ev0czxrupen3" {
    bucket = "hanica-logbucket-1ev0czxrupen3"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "LogBucketPolicy",
  "Statement": [
    {
      "Sid": "WriteAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hanica-logbucket-1ev0czxrupen3/AWSLogs/736134917012/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "hanica-logbucket-1ljc24gzg76i7" {
    bucket = "hanica-logbucket-1ljc24gzg76i7"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "hanica-logbucket-1ljc24gzg76i7" {
    bucket = "hanica-logbucket-1ljc24gzg76i7"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "LogBucketPolicy",
  "Statement": [
    {
      "Sid": "WriteAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hanica-logbucket-1ljc24gzg76i7/AWSLogs/736134917012/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "hanica-logbucket-cxc8o6o2ehgm" {
    bucket = "hanica-logbucket-cxc8o6o2ehgm"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "hanica-logbucket-cxc8o6o2ehgm" {
    bucket = "hanica-logbucket-cxc8o6o2ehgm"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "LogBucketPolicy",
  "Statement": [
    {
      "Sid": "WriteAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hanica-logbucket-cxc8o6o2ehgm/AWSLogs/736134917012/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "hanica-logbucket-yy53p0g4qopp" {
    bucket = "hanica-logbucket-yy53p0g4qopp"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "hanica-logbucket-yy53p0g4qopp" {
    bucket = "hanica-logbucket-yy53p0g4qopp"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "LogBucketPolicy",
  "Statement": [
    {
      "Sid": "WriteAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hanica-logbucket-yy53p0g4qopp/AWSLogs/736134917012/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "kokeshi-elb-logs" {
    bucket = "kokeshi-elb-logs"
    acl    = "private"
    force_destroy = ""
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

resource "aws_s3_bucket" "kokeshi-space" {
    bucket = "kokeshi.space"
    acl    = "private"
    force_destroy = ""

    website {
      index_document = "index.html"
    }
}

resource "aws_s3_bucket" "kufu-terraform-state" {
    bucket = "kufu-terraform-state"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "kufu-test-redshift" {
    bucket = "kufu-test-redshift"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "maintenance-smarthr" {
    bucket = "maintenance-smarthr"
    acl    = "private"
    force_destroy = ""

    website {
      index_document = "maintenance.html"
    }
}

resource "aws_s3_bucket" "mstyle-client" {
    bucket = "mstyle-client"
    acl    = "private"
    force_destroy = ""

    website {
      index_document = "index.html"
    }
}

resource "aws_s3_bucket" "s3-backup-skillsand-me" {
    bucket = "s3.backup.skillsand.me"
    acl    = "private"
    force_destroy = ""

    lifecycle_rule {
      id      = "60days-to-gracier"
      prefix  = ""
      enabled = true

      transition {
        days          = 60
        storage_class = "GLACIER"
      }
    }
}

resource "aws_s3_bucket" "skillsand-me" {
    bucket = "skillsand.me"
    acl    = "private"
    force_destroy = ""

    website {
      error_document = "503.html"
      index_document = "503.html"
    }
}


resource "aws_s3_bucket" "smarthr-api-lp" {
    bucket = "smarthr-api-lp"
    acl    = "private"
    force_destroy = ""
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

resource "aws_s3_bucket" "smarthr-development" {
    bucket = "smarthr-development"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "smarthr-letter-opener" {
    bucket = "smarthr-letter-opener"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "smarthr-notification-integration" {
    bucket = "smarthr-notification-integration"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "smarthr-notification-integration" {
    bucket = "smarthr-notification-integration"
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
      "Resource": "arn:aws:s3:::smarthr-notification-integration/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "smarthr-production" {
    bucket = "smarthr-production"
    acl    = "private"
    force_destroy = ""

    cors_rule {
      allowed_headers = ["Content-*", "Host", "*"]
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["*"]
      max_age_seconds = 3000
    }
}

resource "aws_s3_bucket" "smarthr-qiita-images" {
    bucket = "smarthr-qiita-images"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket_policy" "smarthr-qiita-images" {
    bucket = "smarthr-qiita-images"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::smarthr-qiita-images/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "39.110.215.69",
            "39.111.13.171"
          ]
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "smarthr-redis-persistent-snapshot" {
    bucket = "smarthr-redis-persistent-snapshot"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "smarthr-sandbox" {
    bucket = "smarthr-sandbox"
    acl    = "private"
    force_destroy = ""

    cors_rule {
      allowed_headers = ["Content-*", "Host", "*"]
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["*"]
      max_age_seconds = 3000
    }
}

resource "aws_s3_bucket" "smarthr-staging" {
    bucket = "smarthr-staging"
    acl    = "private"

    cors_rule {
      allowed_headers = ["Content-*", "Host", "*"]
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["*"]
      max_age_seconds = 3000
    }
}

resource "aws_s3_bucket" "smarthr-tmp-development" {
    bucket = "smarthr-tmp-development"
    acl    = "private"
    force_destroy = ""
}

resource "aws_s3_bucket" "yknot-staging" {
    bucket = "yknot-staging"
    acl    = "private"
    force_destroy = ""

    cors_rule {
      allowed_headers = ["Authorization", "Content-*", "Host", "*"]
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["*"]
      max_age_seconds = 3000
    }
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

