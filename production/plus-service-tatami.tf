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
