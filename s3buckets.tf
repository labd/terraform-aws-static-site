data "aws_iam_policy_document" "website_policy" {
  count = var.enabled ? 1 : 0

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.name}",
      "arn:aws:s3:::${var.name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        aws_cloudfront_origin_access_identity.cloudfront_identity.0.iam_arn
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.name}",
      "arn:aws:s3:::${var.name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        var.deploy_role_arn,
      ]
    }
  }
}

resource "aws_s3_bucket" "website" {
  count  = var.enabled ? 1 : 0
  bucket = var.name
  policy = data.aws_iam_policy_document.website_policy.0.json

  website {
    index_document = var.index_document
  }

  cors_rule {
    allowed_origins = ["*"]
    allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
    max_age_seconds = 3000
    allowed_headers = ["*"]
  }

  lifecycle {
    prevent_destroy = true
  }
}
