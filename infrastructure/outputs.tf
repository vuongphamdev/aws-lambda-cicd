output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.hello_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.hello_lambda.function_arn
}

output "aws_region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}