data "aws_iam_policy_document" "lambda" {
  statement {
    sid    = "SourceBucket"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${module.bucket[var.source_bucket_name].s3_bucket_arn}/*"
    ]
  }
  statement {
    sid    = "DestinationBucket"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${module.bucket[var.destination_bucket_name].s3_bucket_arn}/*"
    ]
  }
}
