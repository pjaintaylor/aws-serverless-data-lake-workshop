data "aws_region" "current" {}

locals {
  username = "kdgpoc"
  password = "Kdgpoc1432"
}

resource "aws_cloudformation_stack" "this" {
  name = "Kinesis-Data-Generator-Cognito-User"
  template_url = "https://aws-kdg-tools.s3.${data.aws_region.current.name}.amazonaws.com/cognito-setup.json"
  parameters = {
    Username = local.username
    Password = local.password
  }
  capabilities = ["CAPABILITY_IAM"]
}
