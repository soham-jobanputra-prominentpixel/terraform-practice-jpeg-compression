module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "8.7.0"

  function_name = "image-processor"
  description   = "Processes jpeg images from source bucket and puts it to destination bucket."
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.14"

  create_package          = false
  local_existing_package  = "./dummy-function.zip"
  ignore_source_code_hash = true
}
