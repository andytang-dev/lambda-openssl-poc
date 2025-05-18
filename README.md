# Lambda OpenSSL POC (lambda-openssl-poc)

This is a Proof of Concept (POC) project to demonstrate the creation of an AWS Lambda layer with OpenSSL and its usage in a Lambda function to generate RSA key pairs. The project leverages Docker for building the Lambda layer and Terraform for managing the deployment of the Lambda layer and function.

## Features

- Automates the creation of an AWS Lambda layer with OpenSSL using Docker.
- Uses Terraform to manage the deployment of the Lambda layer and function.
- Demonstrates how to generate RSA key pairs using OpenSSL in a Lambda function.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- [Docker](https://www.docker.com/)
- [Terraform](https://www.terraform.io/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Python 3.x](https://www.python.org/) (for Lambda function development)
- A valid AWS account with IAM permissions to create Lambda functions, layers, and S3 buckets.

## Usage

```bash
terraform init -backend-config=backend/prod.tfbackend
terraform plan -var-file=vars/prod.tfvars
terraform apply -var-file=vars/prod.tfvars

aws lambda invoke --function-name rsa-key-generator --payload '{}' output.json
```

## Acknowledgment

This project was inspired by and references the work done in the [openssl-lambda-layer](https://github.com/alexandredavi/openssl-lambda-layer) repository by [Alexandre Davi](https://github.com/alexandredavi). His project provided valuable insights into building an OpenSSL Lambda layer. This project is built upon similar concepts and adapted for this specific POC. The original repository is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Limitations

- This project is for demonstration purposes and may require adjustments for production use.