resource "aws_lambda_function" "this" {
  description = "Creates a Cognito User Pool, Identity Pool, and a User.  Returns IDs to be used in the Kinesis Data Generator."
  function_name = "KinesisDataGeneratorCognitoSetup"
  handler = "createCognitoPool.createPoolAndUser"
  role = aws_iam_role.lambda_execution_role.arn
  runtime = "nodejs12.x"
  s3_bucket = "aws-kdg-tools-${data.aws_region.current.name}"
  s3_key = "datagen-cognito-setup.zip"
}
