module "bucket" {
  for_each = toset([
    var.source_bucket_name,
    var.destination_bucket_name
  ])

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.12.0"

  bucket           = "${each.key}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an"
  bucket_namespace = "account-regional"
  force_destroy    = true
}

module "event_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "~> 5.12.0"

  bucket = module.bucket[var.source_bucket_name].s3_bucket_id

  lambda_notifications = {
    main = {
      function_arn  = module.lambda.lambda_function_arn
      function_name = module.lambda.lambda_function_name
      events        = ["s3:ObjectCreated:Put"]
      filter_suffix = ".jpg"
    }
  }
}
