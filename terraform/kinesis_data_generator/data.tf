data "aws_region" "current" {}

data "aws_lambda_invocation" "this" {
  function_name = aws_lambda_function.this.function_name
  input = <<JSON
{
  "ServiceToken": "${aws_lambda_function.this.arn}",
  "Region": "${data.aws_region.current.name}",
  "Username": "${random_string.this.result}",
  "Password": "${random_password.this.result}",
  "AuthRoleName": "${aws_iam_role.authenticated_user_role.name}",
  "AuthRoleArn": "${aws_iam_role.authenticated_user_role.arn}",
  "UnauthRoleName": "${aws_iam_role.unauthenticated_user_role.name}",
  "UnauthRoleArn": "${aws_iam_role.unauthenticated_user_role.arn}"
}
JSON
}
