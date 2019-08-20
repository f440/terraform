resource "aws_flow_log" "hanica-vpc-flow-logs" {
  iam_role_arn    = "${aws_iam_role.iam-role-for-hanica-vpc-flow-logs.arn}"
  log_destination = "${aws_cloudwatch_log_group.cloudwatch-log-group-for-hanica-vpc-flow-logs.arn}"
  traffic_type    = "ALL"
  vpc_id          = "vpc-813df2e4"
}

resource "aws_cloudwatch_log_group" "cloudwatch-log-group-for-hanica-vpc-flow-logs" {
  name = "/aws/vpc/hanica-new-vpc-flow-logs"
}

resource "aws_iam_role" "iam-role-for-hanica-vpc-flow-logs" {
  name = "VpcFlowLogsRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam-role-policy-for-hanica-vpc-flow-logs" {
  name = "vpcFlowLogsRolePolicy"
  role = "${aws_iam_role.example.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}