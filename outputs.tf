output "bucket_id" {
  value = aws_s3_bucket.origin.id
}

output "distribution_id" {
  value = aws_cloudfront_distribution.distribution.id
}
