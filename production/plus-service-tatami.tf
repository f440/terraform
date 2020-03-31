##################################################
#
# ECS / ECR
#
##################################################

resource "aws_ecs_cluster" "tatami-production" {
  name = "tatmai-production"
}

resource "aws_ecr_repository" "tatami" {
  name = "tatami"
}

resource "aws_ecr_repository" "tatami-base" {
  name = "tatami/base"
}

resource "aws_ecr_repository" "tatami-fluentd" {
  name = "tatami/fluentd"
}

resource "aws_ecr_repository" "tatami-one-off" {
  name = "tatami/one-off"
}
