data "template_file" "basicauth" {
  count    = "${length(var.authentication) > 0 ? "${var.enabled ? 1 : 0}" : "0"}"
  template = "${file("${path.module}/templates/basicauth.js")}"

  vars = {
    authentication = "${jsonencode(var.authentication)}"
  }
}

data "archive_file" "basicauth" {
  count       = "${length(var.authentication) > 0 ? "${var.enabled ? 1 : 0}" : "0"}"
  type        = "zip"
  output_path = "./files/lambda/${var.name}-basicauth.zip"

  source {
    content  = "${data.template_file.basicauth.rendered}"
    filename = "index.js"
  }
}

resource "aws_lambda_function" "basicauth" {
  count            = "${length(var.authentication) > 0 ? "${var.enabled ? 1 : 0}" : "0"}"
  provider         = "aws.useast"
  filename         = "${data.archive_file.basicauth.output_path}"
  function_name    = "${var.name}-basicauth"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.basicauth.output_base64sha256}"
  runtime          = "nodejs8.10"
  publish          = true
}
