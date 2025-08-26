data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_file
  output_path = "lambda-${var.environment}.zip"
}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = var.tags
}