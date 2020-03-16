resource "aws_iam_role" "security" {
  name               = "security"
  assume_role_policy = file("./files/iam/roles/account-assume.json")
}

resource "aws_iam_role_policy" "security-role-policy" {
  name   = "SecurityRolePolicy"
  role   = aws_iam_role.security.name
  policy = data.aws_iam_policy_document.security-role-policy.json
}

# NOTE: その他のサービス Readonly
resource "aws_iam_role_policy_attachment" "security-role-readonly" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# NOTE: セキュリティ系サービスのフル権限
# Amazon Inspector
resource "aws_iam_role_policy_attachment" "security-role-inspector" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonInspectorFullAccess"
}

# GuardDuty
resource "aws_iam_role_policy_attachment" "security-role-guardduty" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonGuardDutyFullAccess"
}

# Security Hub
resource "aws_iam_role_policy_attachment" "security-role-securityhub" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSecurityHubFullAccess"
}

# AWS WAF
resource "aws_iam_role_policy_attachment" "security-role-waf" {
  role       = aws_iam_role.security.name
  policy_arn = "arn:aws:iam::aws:policy/AWSWAFFullAccess"
}

# NOTE: AWS Config権限、およびその他の付随サービス(削除系は念のため未許可)
data "aws_iam_policy_document" "security-role-policy" {
  # AWS Config (Remediation系以外)
  statement {
    effect = "Allow"
    actions = [
      "config:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "config:DeleteRemediationConfiguration",
      "config:DeleteRemediationExceptions",
      "config:PutRemediationConfigurations",
      "config:PutRemediationExceptions",
      "config:StartRemediationExecution"
    ]
    resources = ["*"]
  }

  # EC2インスタンスへのInspectorタグ付け
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]
    resources = ["*"]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["AmazonInspectorProfile"]
    }
  }

  # SSM Run CommandでInspecotr Agentのインストール
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

  statement {
    effect = "Allow"
    actions = [
      "ssm:SendCommand"
    ]
    resources = ["arn:aws:ssm:*:*:document/*"]
  }

  # SSM パッチ管理
  statement {
    effect = "Allow"
    actions = [
      "ssm:CreatePatchBaseline",
      "ssm:DeletePatchBaseline",
      "ssm:DeregisterPatchBaselineForPatchGroup",
      "ssm:RegisterDefaultPatchBaseline",
      "ssm:RegisterPatchBaselineForPatchGroup",
      "ssm:UpdatePatchBaseline"
    ]
    resources = ["*"]
  }

  # SNS (タグ付きのみ)
  statement {
    effect = "Allow"
    actions = [
      "sns:CreateTopic",
      "sns:TagResource"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "sns:Subscribe"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # IAM ロール関連 (タグがついているもののみ)
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:AttachRolePolicy",
      "iam:PutRolePolicy",
      "iam:PassRole",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # NOTE: Policy, Instance Profileはタグで条件が付けられない
  statement {
    effect = "Allow"
    actions = [
      "iam:CreatePolicy",
      "iam:CreateInstanceProfile",
      "iam:AddRoleToInstanceProfile"
    ]
    resources = ["*"]
  }

  # Security Group
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateSecurityGroup"
    ]
    resources = ["*"]
  }

  # 管理タグの付与
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # 変更はタグ付きのみ
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # Lambda
  statement {
    effect = "Allow"
    actions = [
      "lambda:CreateFunction",
      "lambda:CreateEventSourceMapping",
      "lambda:AddPermission",
      "lambda:InvokeFunction",
      "lambda:PublishVersion",
      "lambda:PutFunctionConcurrency",
      "lambda:UpdateEventSourceMapping",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration"
    ]
    resources = ["*"]
  }

  # CloudWatch アラーム設定(タグ付きのみ)
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:TagResource"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # CloudWatch Events
  statement {
    effect = "Allow"
    actions = [
      "events:ActivateEventSource",
      "events:CreateEventBus",
      "events:EnableRule",
      "events:PutEvents",
      "events:PutPermission",
      "events:PutRule",
      "events:PutTargets"
    ]
    resources = ["*"]
  }

  # CloudWatch Logs
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:AssociateKmsKey"
    ]
    resources = ["*"]
  }

  # Key Management Service
  statement {
    effect = "Allow"
    actions = [
      "kms:CreateKey",
      "kms:TagResource"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:EnableKey",
      "kms:EnableKeyRotation",
      "kms:PutKeyPolicy",
      "kms:UpdateKeyDescription"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/ManagedBy"
      values   = ["SecurityGroup"]
    }
  }

  # Chatbot (SecurityHubからのSlack通知用)
  statement {
    effect = "Allow"
    actions = [
      "chatbot:CreateSlackChannelConfiguration",
      "chatbot:UpdateSlackChannelConfiguration",
      "chatbot:RedeemSlackOauthCode"
    ]
    resources = ["*"]
  }

  # Kinesis Firehose
  statement {
    effect = "Allow"
    actions = [
      "firehose:CreateDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
      "firehose:StartDeliveryStreamEncryption",
      "firehose:TagDeliveryStream",
      "firehose:UpdateDestination"
    ]
    resources = ["*"]
  }

  # SQS
  # NOTE: タグで条件が付けられない
  #       https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsqs.html#amazonsqs-policy-keys
  statement {
    effect = "Allow"
    actions = [
      "sqs:CreateQueue",
      "sqs:TagQueue",
      "sqs:AddPermission",
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:SetQueueAttributes"
    ]
    resources = ["*"]
  }

  # Terraformのstate
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      # production
      "arn:aws:s3:::kufu-terraform-state/production-terraform.tfstate",
      # cloudflare
      "arn:aws:s3:::kufu-terraform-state/cloudflare/cloudflare-terraform.tfstate"
    ]
  }
}
