variable "codedeploy_app_name" {
  description = "The name of the CodeDeploy application"
  type        = string
}

variable "deployment_group_name" {
  description = "The name of the deployment group"
  type        = string
}

variable "codedeploy_role" {
  description = "The IAM role ARN for CodeDeploy"
  type        = string
}

variable "deployment_config_name" {
  description = "The deployment configuration (e.g., CodeDeployDefault.ECSAllAtOnce)"
  type        = string
  default     = "CodeDeployDefault.ECSAllAtOnce"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "termination_wait_time_in_minutes" {
  description = "Time to wait before terminating the old version"
  type        = number
  default     = 5
}

variable "listener_arns" {
  description = "List of listener ARNs for the load balancer"
  type        = list(string)
}

variable "blue_target_group_name" {
  description = "The name of the blue target group"
  type        = string
}

variable "green_target_group_name" {
  description = "The name of the green target group"
  type        = string
}