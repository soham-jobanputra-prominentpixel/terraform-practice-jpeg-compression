provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.7.0"

  function_name = "image-processor"
  description   = "Processes jpeg images from source bucket and puts it to destination bucket."
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.14"

  create_package          = false
  local_existing_package  = "./dummy-function.zip"
  ignore_source_code_hash = true

  attach_policy_statements = true
  policy_statements = {
    SourceBucket = {
      effect = "Allow"
      actions = [
        "s3:GetObject"
      ]
      resources = [
        "${module.bucket.s3_bucket_arn}/*"
      ]
    }
  }
}


module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.12.0"

  bucket           = format("image-processor-source-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  bucket_namespace = "account-regional"
  force_destroy    = true
}


module "event_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "~> 5.12.0"

  bucket = module.bucket.s3_bucket_id

  lambda_notifications = {
    main = {
      function_arn  = module.lambda.lambda_function_arn
      function_name = module.lambda.lambda_function_name
      events        = ["s3:ObjectCreated:Put"]
      filter_suffix = ".jpg"
    }
  }
}
