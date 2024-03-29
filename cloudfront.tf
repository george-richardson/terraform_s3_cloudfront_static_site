resource "aws_cloudfront_distribution" "distribution" {
  enabled             = true
  aliases             = [var.name]
  comment             = "Distribution for ${var.name} generated by Terraform"
  tags                = var.tags
  default_root_object = var.default_root_object

  custom_error_response {
    error_code            = 403 # S3 returns a 403 when an object is not found.
    response_page_path    = var.error_404_object
    response_code         = 404
    error_caching_min_ttl = 300
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = var.name
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name              = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id                = var.name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.certificate.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "origin" {
  name                              = var.name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
