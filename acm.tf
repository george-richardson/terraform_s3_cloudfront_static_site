resource "aws_acm_certificate" "site_certificate" {
  domain_name       = "${var.name}"
  validation_method = "DNS"
  tags              = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

# Validation DNS record is found in route53.tf
resource "aws_acm_certificate_validation" "site_certificate_validation" {
  certificate_arn         = "${aws_acm_certificate.site_certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.site_certificate_validation_record.fqdn}"]
}
