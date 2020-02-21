data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count              = length(var.authentication) > 0 ? var.enabled ? 1 : 0 : 0
  name               = "${var.name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}
