locals {
  name_prefix = "${var.function_name}-${var.environment}"
  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

resource "aws_iam_role" "this" {
  name = "${local.name_prefix}-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
  
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.this.name
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "index.js"
  output_path = "${local.name_prefix}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.name_prefix
  role            = aws_iam_role.this.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  
  tags = local.common_tags
}