data "aws_caller_identity" "current" {}

data "aws_lb" "nodegroupLb-produto" {
  name = "ALB-produto"
}

data "aws_lb" "nodegroupLb-pedido" {
  name = "ALB-pedido"
}

data "aws_lb" "nodegroupLb-pagamento" {
  name = "ALB-pagamento"
}

data "aws_lb" "nodegroupLb-cliente" {
  name = "ALB-cliente"
}

data "aws_lambda_function" "lambda-authorizer" {
  function_name = "identity-authorizer"
}

data "aws_iam_role" "LabRole" {
  name = "LabRole"
}