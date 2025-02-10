module "codedeploy" {
  source                 = "./modules/codedeploy"

  codedeploy_app_name    = lower("${var.pipeline_name}-app")
  codedeploy_role        = aws_iam_role.codedeploy.arn
  deployment_group_name  = lower("${var.pipeline_name}-dg")
  ecs_service_name       = var.ecs_service_name
  ecs_cluster_name       = var.ecs_cluster_name
 # blue_target_group_name = var.blue_target_group_name
 # green_target_group_name = var.green_target_group_name
 # listener_arns           = var.listener_arns
}

resource "aws_iam_role" "codedeploy" {
  name               = "${var.pipeline_name}-codedeploy"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume.json
}

data "aws_iam_policy_document" "codedeploy_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  role       = aws_iam_role.codedeploy.name
  policy_arn = var.codedeploy_policy == null ? aws_iam_policy.codedeploy.arn : var.codedeploy_policy
}

resource "aws_iam_policy" "codedeploy" {
  name   = aws_iam_role.codedeploy.name
  policy = data.aws_iam_policy_document.codedeploy.json
}

data "aws_iam_policy_document" "codedeploy" {
  statement {
    effect = "Allow"
    actions = [
      "codedeploy:*",
      "ecs:UpdateService",
      "ecs:DescribeServices",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyTargetGroup",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3:GetObject",
      "s3:PutObject",
      "ssm:GetParameters",
      "iam:PassRole"
    ]
    resources = ["*"]
  }
}