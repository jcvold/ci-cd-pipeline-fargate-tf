resource "aws_ecs_service" "service-bluegreen" {
  name                = "service-bluegreen"
  cluster             = aws_ecs_cluster.tutorial-bluegreen-cluster.id
  task_definition     = aws_ecs_task_definition.bg-task-def.arn
  desired_count       = 1
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  deployment_controller {
    type = "CODE_DEPLOY"
  }
  network_configuration {
    subnets          = [for subnet in module.vpc.public_subnet_attributes_by_az : subnet.id]
    security_groups  = [aws_security_group.lb_sg.id]
    assign_public_ip = true
  }

  #   iam_role        = aws_iam_role.foo.arn
  #   depends_on      = [aws_iam_role_policy.foo]

  load_balancer {
    target_group_arn = aws_lb_target_group.bluegreentarget1.arn
    container_name   = "sample-app"
    container_port   = 80
  }

  #   placement_constraints {
  #     type       = "memberOf"
  #     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  #   }
}
