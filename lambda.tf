data "archive_file" "basicauth" {
  count       = length(var.authentication) > 0 ? var.enabled ? 1 : 0 : 0
  type        = "zip"
  output_path = "./files/lambda/${var.name}-basicauth.zip"

  source {
    content = templatefile("${path.module}/templates/basicauth.js", {
      authentication = "${jsonencode(var.authentication)}"
    })
    filename = "index.js"
  }
}

resource "aws_lambda_function" "basicauth" {
  count            = length(var.authentication) > 0 ? var.enabled ? 1 : 0 : 0
  provider         = aws.useast
  filename         = data.archive_file.basicauth.0.output_path
  function_name    = "${var.name}-basicauth"
  role             = aws_iam_role.lambda.0.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.basicauth.0.output_base64sha256
  runtime          = "nodejs16.x"
  publish          = true
}
