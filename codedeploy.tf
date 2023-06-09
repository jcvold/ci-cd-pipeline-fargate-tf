data "aws_iam_role" "ecsCodeDeployRole" {
  name = "ecsCodeDeployRole"
}

resource "aws_codedeploy_app" "tutorial-bluegreen-app" {
  compute_platform = "ECS"
  name             = "tutorial-bluegreen-app"
}

resource "aws_codedeploy_deployment_group" "tutorial-deployment-group" {
  app_name = aws_codedeploy_app.tutorial-bluegreen-app.name
  # deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name = "tutorial-bluegreen-dg"
  service_role_arn      = data.aws_iam_role.ecsCodeDeployRole.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.tutorial-bluegreen-cluster.name
    service_name = aws_ecs_service.service-bluegreen.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.bgtarget1-listener.arn]
      }

      target_group {
        name = aws_lb_target_group.bluegreentarget1.name
      }

      target_group {
        name = aws_lb_target_group.bluegreentarget2.name
      }
    }
  }
}
