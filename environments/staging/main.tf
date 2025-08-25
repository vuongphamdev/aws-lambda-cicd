terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "hello_lambda" {
  source = "../../modules/lambda"
  
  function_name = "hello-lambda"
  environment   = "staging"
  
  tags = {
    Project = "lambda-cicd"
    Owner   = "qa-team"
  }
}