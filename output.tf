locals {
  domain_names = [
    "${aws_cloudfront_distribution.cloudfront_basicauth.*.domain_name}",
    "${aws_cloudfront_distribution.cloudfront.*.domain_name}",
  ]

  hosted_zone_ids = [
    "${aws_cloudfront_distribution.cloudfront_basicauth.*.hosted_zone_id}",
    "${aws_cloudfront_distribution.cloudfront.*.hosted_zone_id}",
  ]
}

output "domain_name" {
  value = "${length(local.domain_names) > 0 ? element(local.domain_names, 0) : ""}"
}

output "hosted_zone_id" {
  value = "${length(local.hosted_zone_ids) > 0 ? element(local.hosted_zone_ids, 0) : ""}"
}
