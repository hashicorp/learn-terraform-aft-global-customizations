data "aws_iam_policy_document" "assume-root-role-policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = "${var.trusted_entities}"
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        "true",
      ]
    }

    condition {
      test     = "StringLike"
      variable = "sts:RoleSessionName"

      values = [
        "$${aws:username}*"
      ]
    }
  }
}

resource "aws_iam_role" "itv-root" {
  name                 = "itv-root"
  path                 = "/"
  max_session_duration = "21600"
  assume_role_policy   = data.aws_iam_policy_document.assume-root-role-policy.json
  managed_policy_arns  = "arn:aws:iam::aws:policy/AdministratorAccess"
}
