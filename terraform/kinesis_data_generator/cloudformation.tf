data "aws_region" "current" {}

resource "random_string" "this" {
  length = 8
}

resource "random_password" "this" {
  length = 8
  min_numeric = 1
}

resource "aws_cloudformation_stack" "this" {
  name = "Kinesis-Data-Generator-Cognito-User"
  template_url = "https://aws-kdg-tools.s3.${data.aws_region.current.name}.amazonaws.com/cognito-setup.json"
  parameters = {
    Username = random_string.this.result
    Password = random_password.this.result
  }
}
