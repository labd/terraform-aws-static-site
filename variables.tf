# variable "name" {}
# variable "prefix" {}
# variable "environment" {}

variable "name" {
  type = "string"
}

variable "description" {
  type        = "string"
  description = "Description for CloudFront"
  default     = ""
}

variable "authentication" {
  type        = "list"
  description = "List of username:password for Basic Authentication"
  default     = []
}

variable "index_document" {
  type    = "string"
  default = "index.html"
}

variable "domains" {
  type = "list"
}

variable "deploy_role_arn" {}
variable "ssl_certificate_arn" {}

variable "aws_waf_rule_id" {
  default = ""
}
