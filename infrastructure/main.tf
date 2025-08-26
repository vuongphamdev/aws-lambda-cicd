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

module "hello_lambda" {
  source = "./modules/lambda"
  
  function_name = "hello-lambda-${var.environment}"
  environment   = var.environment
  source_file   = "../software/hello-lambda/index.js"
  tags          = local.common_tags
}