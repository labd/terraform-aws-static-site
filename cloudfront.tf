resource "aws_cloudfront_origin_access_identity" "cloudfront_identity" {
  comment = "${var.description} CloudFront"
}

resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  comment             = "${var.description}"
  default_root_object = "index.html"
  aliases             = ["${var.domains}"]
  price_class         = "PriceClass_100"     # Run in EU and USA (no ASIA)

  origin {
    domain_name = "${aws_s3_bucket.website.bucket_domain_name}"
    origin_id   = "s3-public"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.cloudfront_identity.cloudfront_access_identity_path}"
    }
  }

  /* DEFAULT */
  default_cache_behavior {
    target_origin_id       = "s3-public"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    compress        = true

    cached_methods = ["GET", "HEAD"]
    min_ttl        = 0
    default_ttl    = 3600
    max_ttl        = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = "${aws_lambda_function.basicauth.qualified_arn}"
    }
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 5
  }

  custom_error_response {
    error_code            = 500
    error_caching_min_ttl = 5
  }

  custom_error_response {
    error_code            = 502
    error_caching_min_ttl = 5
  }

  custom_error_response {
    error_code            = 503
    error_caching_min_ttl = 5
  }

  custom_error_response {
    error_code            = 504
    error_caching_min_ttl = 10
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = "${var.ssl_certificate_arn}"
    minimum_protocol_version       = "TLSv1.2_2018"
    ssl_support_method             = "sni-only"
  }
}
