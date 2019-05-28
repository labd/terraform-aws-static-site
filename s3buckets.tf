data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${local.full_name}",
      "arn:aws:s3:::${local.full_name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${aws_cloudfront_origin_access_identity.cloudfront_identity.iam_arn}",
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${local.full_name}",
      "arn:aws:s3:::${local.full_name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${var.deploy_role_arn}",
      ]
    }
  }
}

resource "aws_s3_bucket" "website" {
  bucket = "${local.full_name}"
  policy = "${data.aws_iam_policy_document.website_policy.json}"

  website {
    index_document = "index.html"
  }

  lifecycle {
    prevent_destroy = true
  }
}
