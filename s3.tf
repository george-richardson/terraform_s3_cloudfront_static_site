resource "aws_s3_bucket" "site_bucket" {
  bucket = "${var.name}"
  acl    = "private"
  region = "${var.region}"
  policy = "${data.aws_iam_policy_document.bucket_policy.json}"
  tags   = "${var.tags}"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}
