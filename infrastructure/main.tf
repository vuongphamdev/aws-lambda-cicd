terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

data "aws_region" "current" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../software/hello-lambda/index.js"
  output_path = "lambda-${var.environment}.zip"
}

resource "aws_lambda_function" "hello_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "hello-lambda-${var.environment}"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = local.common_tags
}