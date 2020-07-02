data "aws_iam_policy_document" "kong-ssm" {
  statement {
    actions   = ["ssm:DescribeParameters"]
    resources = ["*"]
  }

  statement {
    actions   = ["ssm:GetParameter"]
    resources = ["arn:aws:ssm:*:*:parameter/${var.service}/${var.environment}/*"]
  }

  statement {
    actions   = ["kms:Decrypt"]
    resources = [aws_kms_alias.kongDev.target_key_arn]
  }
}

resource "aws_iam_role_policy" "kong-ssm" {
  name = format("%s-%s-ssm", var.service, var.environment)
  role = aws_iam_role.kongDev.id

  policy = data.aws_iam_policy_document.kongDev-ssm.json
}

data "aws_iam_policy_document" "kongDev" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "kongDev" {
  name               = format("%s-%s", var.service, var.environment)
  assume_role_policy = data.aws_iam_policy_document.kongDev.json
}

resource "aws_iam_instance_profile" "kongDev" {
  name = format("%s-%s", var.service, var.environment)
  role = aws_iam_role.kongDev.id
}
