data "aws_route53_zone" "hosted_zone" {
  zone_id = "${var.hosted_zone_id}"
}

resource "aws_route53_record" "site_certificate_validation_record" {
  zone_id = "${data.aws_route53_zone.hosted_zone.zone_id}"
  name    = "${aws_acm_certificate.site_certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.site_certificate.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.site_certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "site_record" {
  zone_id = "${data.aws_route53_zone.hosted_zone.zone_id}"
  name    = "${var.name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.site_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
