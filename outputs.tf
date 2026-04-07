output "tail_lambda_function" {
  description = "Use this command to see lambda function logs"
  value       = "aws logs tail ${module.lambda.lambda_cloudwatch_log_group_name}"
}

output "list_source_bucket" {
  description = "Use this command to list objects in source bucket"
  value       = "aws s3 ls s3://${module.bucket[var.source_bucket_name].s3_bucket_id}"
}

output "list_destination_bucket" {
  description = "Use this command to list objects in destination bucket"
  value       = "aws s3 ls s3://${module.bucket[var.destination_bucket_name].s3_bucket_id}"
}
