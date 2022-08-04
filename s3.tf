resource "aws_s3_bucket" "origin" {
  bucket = var.bucket_name == "" ? var.name : var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "origin" {
  bucket = aws_s3_bucket.origin.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "origin" {
  bucket = aws_s3_bucket.origin.id
  policy = data.aws_iam_policy_document.origin_bucket_policy.json
}

data "aws_iam_policy_document" "origin_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}
