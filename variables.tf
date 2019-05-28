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

variable "domains" {
  type = "list"
}

variable "deploy_role_arn" {}
variable "ssl_certificate_arn" {}
