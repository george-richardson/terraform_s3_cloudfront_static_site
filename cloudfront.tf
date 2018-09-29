resource "aws_cloudfront_distribution" "site_distribution" {
  enabled             = true
  aliases             = ["${var.name}"]
  comment             = "Distribution for ${var.name} generated with terraform"
  tags                = "${var.tags}"
  default_root_object = "${var.default_root_object}"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = "${var.name}"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = "${aws_s3_bucket.site_bucket.bucket_regional_domain_name}"
    origin_id   = "${var.name}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.site_certificate.arn}"
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Access identity for ${var.name}"
}
