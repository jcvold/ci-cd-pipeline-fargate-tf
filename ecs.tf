resource "aws_ecs_cluster" "tutorial-bluegreen-cluster" {
  name = "tutorial-bluegreen-cluster"

  #   setting {
  #     name  = "containerInsights"
  #     value = "enabled"
  #   }
}
