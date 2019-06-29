resource "aws_waf_web_acl" "main" {
  count       = "${lenght(var.aws_waf_rule_id) > 0 ? "${var.enabled ? 1 : 0}" : 0}"
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
}
