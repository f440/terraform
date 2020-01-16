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
