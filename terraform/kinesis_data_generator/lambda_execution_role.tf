data "aws_iam_policy_document" "lambda_execution_role_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_role_assume_role.json
}

data "aws_iam_policy_document" "lambda_execution_role_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "logs:*"
    ]
    resources = ["arn:aws:logs:*:*:*"]
    effect = "Allow"
  }

  statement {
    actions = [
      "cognito-idp:AdminConfirmSignUp",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:AdminCreateUser"
    ]
    resources = [
      "arn:aws:cognito-idp:*:*:userpool/*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "cognito-idp:CreateUserPool",
      "cognito-identity:*"
    ]
    resources = ["*"]
    effect = "Allow"
  }

  statement {
    actions = [
      "iam:UpdateAssumeRolePolicy"
    ]
    resources = [
      "arn:aws:iam::153787536644:role/Kinesis-Data-Generator-Cogni-AuthenticatedUserRole-3MT24OVJN0L4",
      "arn:aws:iam::153787536644:role/Kinesis-Data-Generator-Cog-UnauthenticatedUserRole-1V3391H9UQIJV"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam::153787536644:role/Kinesis-Data-Generator-Cogni-AuthenticatedUserRole-3MT24OVJN0L4",
      "arn:aws:iam::153787536644:role/Kinesis-Data-Generator-Cog-UnauthenticatedUserRole-1V3391H9UQIJV"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "lambda_execution_role" {
  policy = data.aws_iam_policy_document.lambda_execution_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  policy_arn = aws_iam_policy.lambda_execution_role.arn
  role = aws_iam_role.lambda_execution_role.name
}
