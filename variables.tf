variable "aws-region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "stage" {
  type = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  default     = "openssl-poc"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  default     = "python3.9"
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function"
  default     = 10
}