data "aws_caller_identity" "current" {}

data "aws_lb" "nodegroupLb" {
  name = "ALB-${var.projectName}"
}