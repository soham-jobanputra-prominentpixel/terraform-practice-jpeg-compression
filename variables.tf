variable "aws_profile" {
  description = "The credentials profile used to manage resources"
  type        = string
}

variable "remote_backend_aws_profile" {
  description = "The credentials profile used to manage remote backend"
  type        = string
}

variable "source_bucket_name" {
  description = "Source bucket name will be formatted according to your account regional namespace name. e.g.: 'amzn-s3-demo-bucket' -> 'amzn-s3-demo-bucket-111122223333-us-west-2-an'"
  type        = string
}

variable "destination_bucket_name" {
  description = "Destination bucket name will be formatted according to your account regional namespace name. e.g.: 'amzn-s3-demo-bucket' is converted to 'amzn-s3-demo-bucket-111122223333-us-west-2-an'"
  type        = string
}

variable "lambda_function_name" {
  description = "Name for the image processing lambda function"
  type        = string
}

variable "region" {
  description = "AWS region to create resources at"
  type        = string
  default     = "us-east-1"
}
