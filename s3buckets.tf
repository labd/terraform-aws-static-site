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

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_policy" "website" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.website.0.bucket
  policy = data.aws_iam_policy_document.website_policy.0.json
}

resource "aws_s3_bucket_website_configuration" "website" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.website.0.bucket
  index_document {
    suffix = var.index_document
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.website.0.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "website" {
  count  = var.enabled ? 1 : 0
  bucket = aws_s3_bucket.website.0.bucket

  cors_rule {
    allowed_origins = ["*"]
    allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
    max_age_seconds = 3000
    allowed_headers = ["*"]
  }
}
