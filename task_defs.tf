resource "aws_ecs_task_definition" "bg-task-def" {
  family                   = "bg-task-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "arn:aws:iam::559717033685:role/ecsTaskExecutionRole"
  container_definitions    = file("./fargate-task.json")
}
