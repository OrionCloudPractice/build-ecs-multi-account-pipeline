output "codedeploy_app" {
  value = aws_codedeploy_app.this
}

output "codedeploy_dp" {
  value = aws_codedeploy_deployment_group.this
}