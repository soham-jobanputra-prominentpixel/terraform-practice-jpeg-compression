module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.7.0"

  function_name = var.lambda_function_name
  description   = "Processes jpeg images from source bucket and puts it to destination bucket."
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.14"
  memory_size   = 1024
  timeout       = 15

  create_package          = false
  local_existing_package  = "./lambda_function.zip"
  ignore_source_code_hash = true

  layers = [
    "arn:aws:lambda:us-east-1:770693421928:layer:Klayers-p314-Pillow:1"
  ]

  attach_policy_json = true
  policy_json        = data.aws_iam_policy_document.lambda.json
}
