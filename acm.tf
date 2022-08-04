# Certificates used for cloudfront must be in the us-east-1 region
resource "aws_acm_certificate" "certificate" {
  provider = aws.useast1

  domain_name       = var.name
  validation_method = "DNS"
  tags              = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# Validation DNS record is found in route53.tf
resource "aws_acm_certificate_validation" "site_certificate_validation" {
  provider                = aws.useast1
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}
