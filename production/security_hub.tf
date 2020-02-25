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
variable "securityhub-action-exception" {
  default = "arn:aws:securityhub:ap-northeast-1:736134917012:action/custom/exception"
}

variable "securityhub-action-bestpractice" {
  default = "arn:aws:securityhub:ap-northeast-1:736134917012:action/custom/bestpractice"
}

resource "aws_securityhub_account" "securityhub" {}

# 例外設定のカスタムアクション
resource "aws_iam_role" "securityhub-action-exception-role" {
  name = "SecurityHubActionExceptionRole"

  assume_role_policy = file("./files/iam/roles/lambda-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_iam_role_policy_attachment" "securityhub-action-exception-role-policy-attachment" {
  role       = aws_iam_role.securityhub-action-exception-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

data "aws_iam_policy_document" "securityhub-action-exception-role-policy" {
  statement {
    effect    = "Allow"
    actions   = ["securityhub:UpdateFindings"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "securityhub-action-exception-role-policy" {
  role   = aws_iam_role.securityhub-action-exception-role.name
  policy = data.aws_iam_policy_document.securityhub-action-exception-role-policy.json
}

data "archive_file" "securityhub-action-exception" {
  type        = "zip"
  source_dir  = "./files/lambda/src/securityhub_action_exception"
  output_path = "./files/lambda/dist/securityhub_action_exception.zip"
}

resource "aws_lambda_function" "securityhub-action-exception" {
  function_name = "SecurityHubActionException"

  filename         = data.archive_file.securityhub-action-exception.output_path
  source_code_hash = data.archive_file.securityhub-action-exception.output_base64sha256
  handler          = "securityhub_action_exception.lambda_handler"
  runtime          = "ruby2.5"
  timeout          = 30

  role = aws_iam_role.securityhub-action-exception-role.arn

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_event_rule" "securityhub-action-exception-event" {
  name        = "SecurityHubActionExceptionEvent"
  description = "Security Hub Custom Action for exception"

  event_pattern = templatefile(
    "./files/events/securityhub_custom_action.json",
    { custom_action_arn = var.securityhub-action-exception }
  )
}

resource "aws_lambda_permission" "securityhub-action-exception-permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.securityhub-action-exception.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.securityhub-action-exception-event.arn
}

resource "aws_cloudwatch_event_target" "securityhub-action-exception-target" {
  rule = aws_cloudwatch_event_rule.securityhub-action-exception-event.name
  arn  = aws_lambda_function.securityhub-action-exception.arn
}

# Run Commandのログ出力用CloudWatch Logs

# NOTE: https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html
data "aws_iam_policy_document" "securityhub-log-key-policy" {
  policy_id = "key-default-1"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/security"
      ]
    }
    actions   = ["kms:*"]
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
}

resource "aws_kms_key" "securityhub-log-key" {
  description         = "key for SecurityHub log"
  policy              = data.aws_iam_policy_document.securityhub-log-key-policy.json
  enable_key_rotation = true
  tags = {
    ManagedBy = "SecurityGroup"
  }
}

resource "aws_cloudwatch_log_group" "securityhub-log" {
  name       = "SecurityHubLog"
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
  role       = aws_iam_role.securityhub-action-bestpractice-role.name
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
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["AmazonInspectorProfile"]
    }
  }
}

resource "aws_iam_role_policy" "securityhub-action-bestpractice-role-policy" {
  role   = aws_iam_role.securityhub-action-bestpractice-role.name
  policy = data.aws_iam_policy_document.securityhub-action-bestpractice-role-policy.json
}

data "archive_file" "securityhub-action-bestpractice" {
  type        = "zip"
  source_dir  = "./files/lambda/src/securityhub_action_bestpractice"
  output_path = "./files/lambda/dist/securityhub_action_bestpractice.zip"
}

resource "aws_lambda_function" "securityhub-action-bestpractice" {
  function_name = "SecurityHubActionBestPractice"

  filename         = data.archive_file.securityhub-action-bestpractice.output_path
  source_code_hash = data.archive_file.securityhub-action-bestpractice.output_base64sha256
  handler          = "securityhub_action_bestpractice.lambda_handler"
  runtime          = "ruby2.5"
  timeout          = 30

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
  name        = "SecurityHubActionBestPracticeEvent"
  description = "Security Hub Custom Action for Best Practice"

  event_pattern = templatefile(
    "./files/events/securityhub_custom_action.json",
    { custom_action_arn = var.securityhub-action-bestpractice }
  )
}

resource "aws_lambda_permission" "securityhub-action-bestpractice-permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.securityhub-action-bestpractice.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.securityhub-action-bestpractice-event.arn
}

resource "aws_cloudwatch_event_target" "securityhub-action-bestpractice-target" {
  rule = aws_cloudwatch_event_rule.securityhub-action-bestpractice-event.name
  arn  = aws_lambda_function.securityhub-action-bestpractice.arn
}
