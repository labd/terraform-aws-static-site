locals {
  full_name = "${var.prefix}-${var.environment}-${var.name}"
}

# resource "aws_route53_record" "lp_werkplaatstools" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name    = "leasetools.${aws_route53_zone.main.name}"
#   type    = "A"
#   alias {
#     name                   = "${aws_cloudfront_distribution.lp_werkplaatstools.domain_name}"
#     zone_id                = "${aws_cloudfront_distribution.lp_werkplaatstools.hosted_zone_id}"
#     evaluate_target_health = true
#   }
# }
