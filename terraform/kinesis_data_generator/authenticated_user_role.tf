data "aws_iam_policy_document" "authenticated_user_role_assume_role" {
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

resource "aws_iam_role" "authenticated_user_role" {
  assume_role_policy = data.aws_iam_policy_document.authenticated_user_role_assume_role.json
}

data "aws_iam_policy_document" "authenticated_user_role_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "kinesis:DescribeStream",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]
    resources = [
      "arn:aws:kinesis:*:*:stream/*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "firehose:DescribeDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [
      "arn:aws:firehose:*:*:deliverystream/*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*",
      "cognito-identity:*",
      "ec2:DescribeRegions",
      "firehose:ListDeliveryStreams",
      "kinesis:ListStreams"
    ]
    resources = ["*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "authenticated_user_role" {
  policy = data.aws_iam_policy_document.authenticated_user_role_policy.json
}

resource "aws_iam_role_policy_attachment" "authenticated_user_role" {
  policy_arn = aws_iam_policy.authenticated_user_role.arn
  role = aws_iam_role.authenticated_user_role.name
}
