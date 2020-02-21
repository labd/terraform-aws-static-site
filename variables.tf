variable "name" {
  type = string
}

variable "description" {
  type        = string
  description = "Description for CloudFront"
  default     = ""
}

variable "authentication" {
  type        = list(string)
  description = "List of username:password for Basic Authentication"
  default     = []
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "domains" {
  type = list(string)
}

variable "deploy_role_arn" {
  type = string
}

variable "ssl_certificate_arn" {
  type = string
}

variable "aws_waf_rule_id" {
  type    = string
  default = ""
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable / Disable this environment"
}
