resource "aws_iam_policy" "AWSLambdaInvocation-201703281916" {
    name        = "AWSLambdaInvocation-201703281916"
    path        = "/"
    description = "Provides invoke to Lambda function."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "hanica-jobs_lambda_logs" {
    name        = "hanica-jobs_lambda_logs"
    path        = "/"
    description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "hanica-job_lambda_logs" {
    name        = "hanica-job_lambda_logs"
    path        = "/"
    description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "hanica_lambda_logs" {
    name        = "hanica_lambda_logs"
    path        = "/"
    description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy-s3-hanica-development" {
    name        = "policy-s3-hanica-development"
    path        = "/"
    description = "Allow S3 access for smarthr-development, smarthr-tmp-development bucket."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1495078038000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-development",
        "arn:aws:s3:::smarthr-development/*"
      ]
    },
    {
      "Sid": "Stmt1495078070000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-tmp-development",
        "arn:aws:s3:::smarthr-tmp-development/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy-s3-hanica-kokeshi" {
    name        = "policy-s3-hanica-kokeshi"
    path        = "/"
    description = "Allow S3 access for smarthr-tmp-kokeshi bucket."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1495079231000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-tmp-kokeshi",
        "arn:aws:s3:::smarthr-tmp-kokeshi/*",
        "arn:aws:s3:::smarthr-kokeshi",
        "arn:aws:s3:::smarthr-kokeshi/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy-s3-hanica-production" {
    name        = "policy-s3-hanica-production"
    path        = "/"
    description = "Allow S3 access for smarthr-production, smarthr-tmp-production bucket."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1495077873000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-production",
        "arn:aws:s3:::smarthr-production/*"
      ]
    },
    {
      "Sid": "Stmt1495077903000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-tmp-production",
        "arn:aws:s3:::smarthr-tmp-production/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy-s3-hanica-sandbox" {
    name        = "policy-s3-hanica-sandbox"
    path        = "/"
    description = "Allow S3 access for smarthr-sandbox, smarthr-tmp-sandbox bucket."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1495079348000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-sandbox",
        "arn:aws:s3:::smarthr-sandbox/*"
      ]
    },
    {
      "Sid": "Stmt1495079356000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-tmp-sandbox",
        "arn:aws:s3:::smarthr-tmp-sandbox/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "policy-s3-hanica-staging" {
    name        = "policy-s3-hanica-staging"
    path        = "/"
    description = "Allow S3 access for smarthr-staging, smarthr-tmp-staging bucket."
    policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1495077311000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-staging",
        "arn:aws:s3:::smarthr-staging/*"
      ]
    },
    {
      "Sid": "Stmt1495077339000",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::smarthr-tmp-staging",
        "arn:aws:s3:::smarthr-tmp-staging/*"
      ]
    }
  ]
}
POLICY
}

