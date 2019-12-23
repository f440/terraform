resource "aws_iam_policy" "heroku-tools-alb-maintenance-policy" {
  name = "ALBMaintenanceTool"
  path = "/"
  policy = "${file("./files/iam/policies/heroku-tools-alb-maintenance-policy.json")}"
}
