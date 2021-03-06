locals {
  domain_names = flatten(concat(
    aws_cloudfront_distribution.cloudfront_basicauth.*.domain_name,
    aws_cloudfront_distribution.cloudfront.*.domain_name,
  ))

  hosted_zone_ids = flatten(concat(
    aws_cloudfront_distribution.cloudfront_basicauth.*.hosted_zone_id,
    aws_cloudfront_distribution.cloudfront.*.hosted_zone_id,
  ))
}

output "domain_name" {
  value = length(local.domain_names) == 0 ? "" : local.domain_names[0]
}

output "hosted_zone_id" {
  value = length(local.hosted_zone_ids) == 0 ? "" : local.hosted_zone_ids[0]
}

output "bucket_arn" {
  value = var.enabled ? aws_s3_bucket.website.0.arn : ""
}

output "distribution_arn" {
  value = !var.enabled ? "" : length(var.authentication) > 0 ? aws_cloudfront_distribution.cloudfront_basicauth.0.arn : aws_cloudfront_distribution.cloudfront.0.arn
}