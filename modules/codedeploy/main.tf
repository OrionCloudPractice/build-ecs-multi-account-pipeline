resource "aws_codedeploy_app" "this" {
  name             = var.codedeploy_app_name
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.codedeploy_role

  deployment_config_name = var.deployment_config_name

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }
/*
  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                            = "TERMINATE"
      termination_wait_time_in_minutes  = var.termination_wait_time_in_minutes
    }

    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = var.listener_arns
      }

      target_group {
        name = var.blue_target_group_name
      }

      target_group {
        name = var.green_target_group_name
      }
    }
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = var.target_group_name
      }
      prod_traffic_route {
        listener_arns = [var.listener_arns]
      }
    }
  }
*/
}