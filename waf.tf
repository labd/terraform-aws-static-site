resource "aws_waf_web_acl" "main" {
  name        = "${var.name}"
  metric_name = "${replace(var.name, "-", "")}"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = "${var.aws_waf_rule_id}"
    type     = "REGULAR"
  }

  count = "${length(var.aws_waf_rule_id) > 0 ? 1 : 0}"
}
