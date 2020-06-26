data "aws_region" "current" {}

resource "random_string" "username" {
  length = 16
  special = false
  number = false
}

resource "random_string" "password" {
  length = 16
  special = false
  min_numeric = 1
}

resource "aws_cloudformation_stack" "this" {
  name = "Kinesis-Data-Generator-Cognito-User"
  template_url = "https://aws-kdg-tools.s3.${data.aws_region.current.name}.amazonaws.com/cognito-setup.json"
  parameters = {
    Username = random_string.username.result
    Password = random_string.password.result
  }
  capabilities = ["CAPABILITY_IAM"]
}
