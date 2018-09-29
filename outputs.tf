output "bucket_id" {
  value = "${aws_s3_bucket.site_bucket.id}"
}

output "distribution_id" {
  value = "${aws_cloudfront_distribution.site_distribution.id}"
}
