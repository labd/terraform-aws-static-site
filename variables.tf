variable "name" {}
variable "prefix" {}
variable "environment" {}
variable "description" {}
variable "auth_username" {}
variable "auth_password" {}

variable "domains" {
  type = "list"
}

variable "deploy_role_arn" {}
variable "lambda_role_arn" {}
variable "ssl_certificate_arn" {}
