# TODO: 現状Seucirty HubのカスタムアクションはTerraformがサポートしていないため
#       手動であらかじめ追加をしておく必要がある
#       Terraformでサポートされたら、以下のような形でコード化予定。
#
#resource "aws_securityhub_custom_action" "exception-action" {
#  name = "例外に設定(対応不要)"
#  action_id = "exception"
#  description = "低リスクのため対応不要な脆弱性"
#}
#resource "aws_securityhub_custom_action" "bestpractice-action" {
#  name = "Best Practice適用"
#  action_id = "bestpractice"
#  description = "Best Practiceで推奨された設定を適用"
#}
#resource "aws_securityhub_custom_action" "securitypatch-action" {
#  name = "セキュリティパッチ適用"
#  action_id = "securitypatch"
#  description = "利用可能なセキュリティパッチを適用"
#}
variable "securityhub-action-exception" {
  default = "arn:aws:securityhub:ap-northeast-1:736134917012:action/custom/exception"
}

variable "securityhub-action-bestpractice" {
  default = "arn:aws:securityhub:ap-northeast-1:736134917012:action/custom/bestpractice"
}

variable "securityhub-action-securitypatch" {
  default = "arn:aws:securityhub:ap-northeast-1:736134917012:action/custom/securitypatch"
}

resource "aws_securityhub_account" "securityhub" {}

# NOTE: LambdaのコードはTerraformとは別で管理するために、 Terraformではダミーコードをデプロイしておく。
#       その後、別途実際のコードに差し替える
#       % aws lambda update-function-code --function-name $function_name --zip-file fileb://$source_path –publish
#
#       https://amido.com/blog/terraform-does-not-need-your-code-to-provision-a-lambda-function/
data "archive_file" "lambda-dummy" {
  type        = "zip"
  output_path = "./files/lambda/dummy/lambda_dummy.zip"

  source {
    content = <<EOF
      This is dummy content.
      Please upload your lambda function code.
      % aws lambda update-function-code --function-name $function_name --zip-file fileb://$source_path –publish
    EOF
    filename = ".placeholder"
  }
}

# 例外設定のカスタムアクション
resource "aws_iam_role" "securityhub-action-exception-role" {
  name = "SecurityHubActionExceptionRole"

  assume_role_policy = file("./files/iam/roles/lambda-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role_policy_attachment" "securityhub-action-exception-role-policy-attachment" {
  role = aws_iam_role.securityhub-action-exception-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

data "aws_iam_policy_document" "securityhub-action-exception-role-policy" {
  statement {
    effect = "Allow"
    actions = ["securityhub:UpdateFindings"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "securityhub-action-exception-role-policy" {
  role = aws_iam_role.securityhub-action-exception-role.name
  policy = data.aws_iam_policy_document.securityhub-action-exception-role-policy.json
}

resource "aws_lambda_function" "securityhub-action-exception" {
  function_name = "SecurityHubActionException"

  filename = data.archive_file.lambda-dummy.output_path
  handler = "securityhub_action_exception.lambda_handler"
  runtime = "ruby2.5"
  timeout = 30

  role = aws_iam_role.securityhub-action-exception-role.arn

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_event_rule" "securityhub-action-exception-event" {
  name = "SecurityHubActionExceptionEvent"
  description = "Security Hub Custom Action for exception"

  event_pattern = templatefile(
    "./files/events/securityhub_custom_action.json",
    { custom_action_arn = var.securityhub-action-exception }
  )
}

resource "aws_lambda_permission" "securityhub-action-exception-permission" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.securityhub-action-exception.arn
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.securityhub-action-exception-event.arn
}

resource "aws_cloudwatch_event_target" "securityhub-action-exception-target" {
  rule = aws_cloudwatch_event_rule.securityhub-action-exception-event.name
  arn = aws_lambda_function.securityhub-action-exception.arn
}

# Run Commandのログ出力用CloudWatch Logs

# NOTE: https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html
#       https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-troubleshooting.html#sqs-encrypted
data "aws_iam_policy_document" "securityhub-log-key-policy" {
  policy_id = "key-default-1"
  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/security"
      ]
    }
    actions = ["kms:*"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "logs.${data.aws_region.current.name}.amazonaws.com"
      ]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "securityhub-log-key" {
  description = "key for SecurityHub log"
  policy = data.aws_iam_policy_document.securityhub-log-key-policy.json
  enable_key_rotation = true
  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_log_group" "securityhub-log" {
  name = "SecurityHubLog"
  kms_key_id = aws_kms_key.securityhub-log-key.arn
}

# Best Practice適用のカスタムアクション
resource "aws_iam_role" "securityhub-action-bestpractice-role" {
  name = "SecurityHubActionBestPracticeRole"

  assume_role_policy = file("./files/iam/roles/lambda-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role_policy_attachment" "securityhub-action-bestpractice-role-policy-attachment" {
  role = aws_iam_role.securityhub-action-bestpractice-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

data "aws_iam_policy_document" "securityhub-action-bestpractice-role-policy" {
  statement {
    effect = "Allow"
    actions = [
      "securityhub:UpdateFindings"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:SendCommand"
    ]
    resources = ["*"]
    condition {
      test = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values = ["AmazonInspectorProfile"]
    }
  }
}

resource "aws_iam_role_policy" "securityhub-action-bestpractice-role-policy" {
  role = aws_iam_role.securityhub-action-bestpractice-role.name
  policy = data.aws_iam_policy_document.securityhub-action-bestpractice-role-policy.json
}

resource "aws_lambda_function" "securityhub-action-bestpractice" {
  function_name = "SecurityHubActionBestPractice"

  filename = data.archive_file.lambda-dummy.output_path
  handler = "securityhub_action_bestpractice.lambda_handler"
  runtime = "ruby2.5"
  timeout = 30

  role = aws_iam_role.securityhub-action-bestpractice-role.arn

  environment {
    variables = {
      CLOUDWATCH_LOG_GROUP = aws_cloudwatch_log_group.securityhub-log.name
    }
  }

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_event_rule" "securityhub-action-bestpractice-event" {
  name = "SecurityHubActionBestPracticeEvent"
  description = "Security Hub Custom Action for Best Practice"

  event_pattern = templatefile(
    "./files/events/securityhub_custom_action.json",
    { custom_action_arn = var.securityhub-action-bestpractice }
  )
}

resource "aws_lambda_permission" "securityhub-action-bestpractice-permission" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.securityhub-action-bestpractice.arn
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.securityhub-action-bestpractice-event.arn
}

resource "aws_cloudwatch_event_target" "securityhub-action-bestpractice-target" {
  rule = aws_cloudwatch_event_rule.securityhub-action-bestpractice-event.name
  arn = aws_lambda_function.securityhub-action-bestpractice.arn
}

# セキュリティパッチ適用のカスタムアクション
resource "aws_iam_role" "securityhub-action-securitypatch-role" {
  name = "SecurityHubActionSecurityPatchRole"

  assume_role_policy = file("./files/iam/roles/lambda-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role_policy_attachment" "securityhub-action-securitypatch-role-policy-attachment" {
  role = aws_iam_role.securityhub-action-securitypatch-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

data "aws_iam_policy_document" "securityhub-action-securitypatch-role-policy" {
  statement {
    effect = "Allow"
    actions = [
      "securityhub:UpdateFindings"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:SendCommand"
    ]
    resources = ["*"]
    condition {
      test = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values = ["AmazonInspectorProfile"]
    }
  }
}

resource "aws_iam_role_policy" "securityhub-action-securitypatch-role-policy" {
  role = aws_iam_role.securityhub-action-securitypatch-role.name
  policy = data.aws_iam_policy_document.securityhub-action-securitypatch-role-policy.json
}

resource "aws_lambda_function" "securityhub-action-securitypatch" {
  function_name = "SecurityHubActionSecurityPatch"

  filename = data.archive_file.lambda-dummy.output_path
  handler = "securityhub_action_securitypatch.lambda_handler"
  runtime = "ruby2.5"
  timeout = 30

  role = aws_iam_role.securityhub-action-securitypatch-role.arn

  environment {
    variables = {
      CLOUDWATCH_LOG_GROUP = aws_cloudwatch_log_group.securityhub-log.name
    }
  }

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_event_rule" "securityhub-action-securitypatch-event" {
  name = "SecurityHubActionSecurityPatchEvent"
  description = "Security Hub Custom Action for Security Patch"

  event_pattern = templatefile(
    "./files/events/securityhub_custom_action.json",
    { custom_action_arn = var.securityhub-action-securitypatch }
  )
}

resource "aws_lambda_permission" "securityhub-action-securitypatch-permission" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.securityhub-action-securitypatch.arn
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.securityhub-action-securitypatch-event.arn
}

resource "aws_cloudwatch_event_target" "securityhub-action-securitypatch-target" {
  rule = aws_cloudwatch_event_rule.securityhub-action-securitypatch-event.name
  arn = aws_lambda_function.securityhub-action-securitypatch.arn
}

# 通知
data "template_file" "securityhub-imported-event" {
  template = file("./files/events/securityhub_imported.json")
  vars = {
    aws_region = data.aws_region.current.name
  }
}

resource "aws_cloudwatch_event_rule" "securityhub-notification-rule" {
  name = "SecurityHubNotification"
  description = "Forward Security Hub events to Lambda for notifcation"

  event_pattern = data.template_file.securityhub-imported-event.rendered
}

resource "aws_sqs_queue" "securityhub-notification-queue" {
  name = "SecurityHubNotificationQueue"
  kms_master_key_id = aws_kms_key.securityhub-log-key.key_id

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/resource-based-policies-cwe.html#sqs-permissions
data "aws_iam_policy_document" "securityhub-notification-queue-policy" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions = [
      "sqs:SendMessage"
    ]
    resources = [aws_sqs_queue.securityhub-notification-queue.arn]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = [aws_cloudwatch_event_rule.securityhub-notification-rule.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "securityhub-notification-queue-policy" {
  queue_url = aws_sqs_queue.securityhub-notification-queue.id
  policy = data.aws_iam_policy_document.securityhub-notification-queue-policy.json
}

resource "aws_cloudwatch_event_target" "seurityhub-notification-target" {
  rule = aws_cloudwatch_event_rule.securityhub-notification-rule.name
  arn = aws_sqs_queue.securityhub-notification-queue.arn
}

resource "aws_sns_topic" "securityhub-notification-topic" {
  name = "SecurityHubNotification"

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role" "lambda-securityhub-filter-role" {
  name = "LambdaSecurityHubFilterRole"
  assume_role_policy = file("./files/iam/roles/lambda-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role_policy_attachment" "lambda-securityhub-filter-role-policy-attachment" {
  role = aws_iam_role.lambda-securityhub-filter-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

data "aws_iam_policy_document" "lambda-securityhub-filter-role-policy" {
  statement {
    effect = "Allow"
    actions = ["SNS:Publish"]
    resources = [aws_sns_topic.securityhub-notification-topic.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [aws_sqs_queue.securityhub-notification-queue.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = [aws_kms_key.securityhub-log-key.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "securityhub:GetFindings",
      "securityhub:UpdateFindings",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda-securityhub-filter-role-policy" {
  role = aws_iam_role.lambda-securityhub-filter-role.name
  policy = data.aws_iam_policy_document.lambda-securityhub-filter-role-policy.json
}

resource "aws_lambda_function" "lambda-securityhub-filter" {
  function_name = "SecurityHubNotificationFilter"

  filename = data.archive_file.lambda-dummy.output_path

  handler = "securityhub_notification_filter.lambda_handler"
  runtime = "ruby2.5"
  timeout = 30
  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.securityhub-notification-topic.arn
    }
  }
  # NOTE: TooManyRequestErrorを出にくくするために同時実行を減らす
  reserved_concurrent_executions = 1

  role = aws_iam_role.lambda-securityhub-filter-role.arn

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_lambda_event_source_mapping" "securityhub-notification-mapping" {
  event_source_arn = aws_sqs_queue.securityhub-notification-queue.arn
  function_name = aws_lambda_function.lambda-securityhub-filter.arn
}

resource "aws_cloudwatch_metric_alarm" "securityhub-notification-queue-alarm" {
  alarm_name = "SecurityHubNotificationQueueAlarm"

  namespace = "AWS/SQS"
  metric_name = "ApproximateNumberOfMessagesNotVisible"
  dimensions = {
    QueueName = aws_sqs_queue.securityhub-notification-queue.name
  }

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  period = "300"
  statistic = "Minimum"
  threshold = "0"

  alarm_actions = [aws_sns_topic.securityhub-notification-topic.arn]

  tags = {
    ManagedBy = "SecurityGroup"
  }
}
