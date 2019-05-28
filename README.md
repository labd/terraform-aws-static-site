Terraform AWS Static Site
=========================

Usage
-----

```
module "static_site" {
  source = "git::ssh://git@github.com/labd/terraform-aws-static-site"

  name                = "full-name-for-s3-bucket"
  description         = "Description for CloudFront"            # Optional
  deploy_role_arn     = "${module.ecs_deploy_role.role_arn}"
  ssl_certificate_arn = "..."                                   # Certificate has to be within the US-East-1 region

  authentication = [
    "username:password",
  ]

  domains = [
    "sub.example.com",
  ]

  providers = {
    aws        = "aws"
    aws.useast = "aws.useast"  # Required for Lambda@Edge
  }
}
```

Output
------

 - domain_name = CloudFront domain name for Route53
 - hosted_zone_id = CloudFront hosted zone id for Route53
