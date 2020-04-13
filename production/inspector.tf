resource "aws_inspector_resource_group" "group-base" {
  tags = {
    AmazonInspectorProfile = "base_inspector_group"
  }
}

resource "aws_inspector_assessment_target" "target-base" {
  name               = "base_inspector_group"
  resource_group_arn = aws_inspector_resource_group.group-base.arn
}

resource "aws_inspector_assessment_template" "template-base" {
  name       = "base_inspector_group_template"
  target_arn = aws_inspector_assessment_target.target-base.arn
  duration   = 180

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html#ap-northeast-1
  rules_package_arns = [
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT", # CVE
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq"  # Best Practices
  ]
}


resource "aws_inspector_resource_group" "group-base-network" {
  tags = {
    AmazonInspectorProfile = "base+network_inspector_group"
  }
}

resource "aws_inspector_assessment_target" "target-base-network" {
  name               = "base+network_inspector_group"
  resource_group_arn = aws_inspector_resource_group.group-base-network.arn
}

resource "aws_inspector_assessment_template" "template-base-network" {
  name       = "base+network_inspector_group_template"
  target_arn = aws_inspector_assessment_target.target-base-network.arn
  duration   = 180

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html#ap-northeast-1
  rules_package_arns = [
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT", # CVE
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq", # Best Practices
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-YI95DVd7"  # Network Reachability
  ]
}

# 定期実行スケジュール
resource "aws_iam_role" "inspector-schedule-role" {
  name               = "AmazonInspectorScheduleRunRole"
  assume_role_policy = file("./files/iam/roles/events-assume.json")

  tags = {
    ManagedBy = "SecurityGroup"
  }
}

data "aws_iam_policy_document" "inspector-schedule-policy" {
  statement {
    effect = "Allow"
    actions = [
      "inspector:StartAssessmentRun"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "inspector-schedule-role-policy" {
  name   = "InspectorAssessmentRun"
  role   = aws_iam_role.inspector-schedule-role.name
  policy = data.aws_iam_policy_document.inspector-schedule-policy.json
}

resource "aws_cloudwatch_event_rule" "inspector-schedule-rule" {
  name                = "AmazonInspectorScheduleRunRule"
  description         = "Run Amazon Inspector Assessment periodically"
  schedule_expression = "cron(30 7 ? * TUE *)"
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "inspector-schedule-target-base" {
  rule      = aws_cloudwatch_event_rule.inspector-schedule-rule.name
  target_id = "AmazonInspectorAssesmentBase"
  arn       = aws_inspector_assessment_template.template-base.arn
  role_arn  = aws_iam_role.inspector-schedule-role.arn
}

resource "aws_cloudwatch_event_target" "inspector-schedule-target-basenetwork" {
  rule      = aws_cloudwatch_event_rule.inspector-schedule-rule.name
  target_id = "AmazonInspectorAssesmentBaseNetwork"
  arn       = aws_inspector_assessment_template.template-base-network.arn
  role_arn  = aws_iam_role.inspector-schedule-role.arn
}
