data "aws_caller_identity" "current" {}

data "aws_lb" "nodegroupLb" {
  name = "ALB-${var.projectName}"
}

data "aws_lambda_function" "lambda-authorizer" {
  function_name = "identity-authorizer"
}

data "aws_iam_role" "LabRole" {
  name = "LabRole"
}