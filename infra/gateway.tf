resource "aws_api_gateway_rest_api" "app" {
  name = "${var.projectName}-api"
  body = templatefile("${path.module}/openapi.yaml", {
    userPoolId             = aws_cognito_user_pool.userpool.id
    region                 = var.regionDefault
    eks_url                = data.aws_lb.nodegroupLb.dns_name
    audience               = aws_cognito_user_pool_client.userpool_client.id
    accountId              = data.aws_caller_identity.current.id
    lambda_identify_client = data.aws_lambda_function.lambda-authorizer.arn
    role                   = data.aws_iam_role.LabRole.arn
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "app" {
  depends_on  = [aws_api_gateway_rest_api.app, aws_cognito_user_pool_client.userpool_client]
  rest_api_id = aws_api_gateway_rest_api.app.id
  description = "${var.projectName} Deployment"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "app" {
  depends_on = [aws_api_gateway_rest_api.app, aws_cognito_user_pool_client.userpool_client]

  deployment_id = aws_api_gateway_deployment.app.id
  rest_api_id   = aws_api_gateway_rest_api.app.id
  stage_name    = "v1"
}
