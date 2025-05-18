module "label_lambda" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=main"
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  name        = "lambda"
  label_order = ["namespace", "stage", "environment", "name", "attributes"]
  tags = {
    "Terraform" = "true"
  }
}

# Build the Lambda layer
resource "null_resource" "build_layer" {
  provisioner "local-exec" {
    command     = "bash build.sh"
    working_dir = "${path.module}/lambda_layer/openssl_layer"
  }

  triggers = {
    dockerfile_hash   = filemd5("${path.module}/lambda_layer/openssl_layer/Dockerfile")
    build_script_hash = filemd5("${path.module}/lambda_layer/openssl_layer/build.sh")
    layer_zip_exists  = fileexists("${path.module}/lambda_layer/openssl_layer/layer.zip") ? "exists" : "missing"
  }
}

# Package the Lambda function
data "archive_file" "lambda_function" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code/generate_rsa"
  output_path = "${path.module}/lambda_code/generate_rsa.zip"
}


# Create the Lambda layer
resource "aws_lambda_layer_version" "openssl_layer" {
  layer_name          = "openssl-layer"
  filename            = "${path.module}/lambda_layer/openssl_layer/layer.zip"
  compatible_runtimes = [var.lambda_runtime]
  depends_on          = [null_resource.build_layer]
}

# Lambda function
resource "aws_lambda_function" "rsa_key_generator" {
  function_name = "${module.label_lambda.id}-${var.lambda_function_name}"
  filename      = data.archive_file.lambda_function.output_path
  handler       = "lambda_function.lambda_handler"
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec.arn
  layers        = [aws_lambda_layer_version.openssl_layer.arn]
  timeout       = var.lambda_timeout
  depends_on    = [aws_lambda_layer_version.openssl_layer]
}