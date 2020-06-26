data "aws_iam_policy_document" "unauthenticated_user_role_assume_role" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["cognito-identity.amazonaws.com"]
      type = "Federated"
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}

resource "aws_iam_role" "unauthenticated_user_role" {
  assume_role_policy = data.aws_iam_policy_document.unauthenticated_user_role_assume_role.json
}

data "aws_iam_policy_document" "unauthenticated_user_role_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*"
    ]
    resources = ["*"]
    effect = "Allow"
  }
}
resource "aws_iam_policy" "unauthenticated_user_role" {
  policy = data.aws_iam_policy_document.unauthenticated_user_role_policy.json
}

resource "aws_iam_role_policy_attachment" "unauthenticated_user_role" {
  policy_arn = aws_iam_policy.unauthenticated_user_role.arn
  role = aws_iam_role.unauthenticated_user_role.name
}
