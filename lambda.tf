data "template_file" "basicauth" {
  template = "${file("${path.module}/templates/basicauth.js")}"

  vars = {
    username = "${var.auth_username}"
    password = "${var.auth_password}"
  }
}

data "archive_file" "basicauth" {
  type        = "zip"
  output_path = "${path.module}/files/lambda/${local.full_name}-basicauth.zip"

  source {
    content  = "${data.template_file.basicauth.rendered}"
    filename = "index.js"
  }
}

resource "aws_lambda_function" "basicauth" {
  provider         = "aws.useast"
  filename         = "${data.archive_file.basicauth.output_path}"
  function_name    = "${local.full_name}-basicauth"
  role             = "${var.lambda_role_arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.basicauth.output_base64sha256}"
  runtime          = "nodejs8.10"
  publish          = true
}
