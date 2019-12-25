resource "aws_inspector_resource_group" "group-base" {
  tags = {
    InspectorProfile = "base"
  }
}

resource "aws_inspector_assessment_target" "target-base" {
  name = "Target for base profile"
  resource_group_arn = aws_inspector_resource_group.group-base.arn
}

resource "aws_inspector_assessment_template" "template-base" {
  name = "Template for base profile"
  target_arn = aws_inspector_assessment_target.target-base.arn
  duration = 180

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html#ap-northeast-1
  rules_package_arns = [
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT", # CVE
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq"  # Best Practices
  ]
}


resource "aws_inspector_resource_group" "group-base-network" {
  tags = {
    InspectorProfile = "base+network"
  }
}

resource "aws_inspector_assessment_target" "target-base-network" {
  name = "Target for base+network profile"
  resource_group_arn = aws_inspector_resource_group.group-base-network.arn
}

resource "aws_inspector_assessment_template" "template-base-network" {
  name = "Template for base+network profile"
  target_arn = aws_inspector_assessment_target.target-base-network.arn
  duration = 180

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html#ap-northeast-1
  rules_package_arns = [
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-gHP9oWNT", # CVE
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-bBUQnxMq", # Best Practices
    "arn:aws:inspector:ap-northeast-1:406045910587:rulespackage/0-YI95DVd7"  # Network Reachability
  ]
}
