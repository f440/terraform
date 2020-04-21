resource "aws_s3_bucket" "aws-waf-logs-bucket" {
  # NOTE: Kinesis Firehoseの名前に合わせたバケット名
  bucket = "aws-waf-logs-hanica-production-waf"

  acl           = "private"
  force_destroy = false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# NOTE: Kinesis FirehoseでのS3出力のエラーが記録されるCloudWatch Logs
resource "aws_cloudwatch_log_group" "aws-waf-logs-error" {
  name = "aws-waf-logs-error"
}

resource "aws_cloudwatch_log_stream" "aws-waf-logs-error-hanica-production-waf" {
  name           = "hanica-production-waf"
  log_group_name = aws_cloudwatch_log_group.aws-waf-logs-error.name
}

resource "aws_iam_role" "aws-waf-logs-firehose-role" {
  name               = "HanicaProductionWafLogRole"
  assume_role_policy = file("./files/iam/roles/firehose-assume.json")
}

# NOTE: 必要な権限は以下を参照
#       https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3
data "aws_iam_policy_document" "aws-waf-logs-firehose-role-policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.aws-waf-logs-bucket.arn}",
      "${aws_s3_bucket.aws-waf-logs-bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "aws-waf-logs-firehose-role-policy" {
  name = "${aws_iam_role.aws-waf-logs-firehose-role.name}Policy"

  role   = aws_iam_role.aws-waf-logs-firehose-role.name
  policy = data.aws_iam_policy_document.aws-waf-logs-firehose-role-policy.json
}

resource "aws_kinesis_firehose_delivery_stream" "aws-waf-logs-hanica-production-waf" {
  # NOTE: 名前は `aws-waf-logs-` で始まる必要あり
  #       https://docs.aws.amazon.com/ja_jp/waf/latest/developerguide/logging.html
  name = "aws-waf-logs-hanica-production-waf"

  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.aws-waf-logs-firehose-role.arn
    bucket_arn = aws_s3_bucket.aws-waf-logs-bucket.arn

    compression_format = "GZIP"

    cloudwatch_logging_options {
      enabled         = "true"
      log_group_name  = aws_cloudwatch_log_group.aws-waf-logs-error.name
      log_stream_name = aws_cloudwatch_log_stream.aws-waf-logs-error-hanica-production-waf.name
    }
  }
}

resource "aws_wafregional_web_acl" "hanica-production-waf" {
  name        = "hanica-production-waf"
  metric_name = "hanicaproductionwaf"

  default_action {
    type = "ALLOW"
  }

  logging_configuration {
    log_destination = aws_kinesis_firehose_delivery_stream.aws-waf-logs-hanica-production-waf.arn
  }

  rule {
    priority = 1
    # Fortinet Managed Rules for AWS WAF - SQLi/XSS
    rule_id = "8bcd3b9c-aeb7-4aca-891e-e7b366722d61"
    type    = "GROUP"

    override_action {
      type = "NONE"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "aws-waf-block-alarm" {
  alarm_name = "HanicaProductionWafBlockAlarm"

  namespace   = "WAF"
  metric_name = "BlockedRequests"
  dimensions = {
    WebACL = aws_wafregional_web_acl.hanica-production-waf.metric_name
    Rule   = "ALL"
    Region = data.aws_region.current.name
  }

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.securityhub-notification-topic.arn]

  tags = {
    ManagedBy = "SecurityGroup"
  }
}
