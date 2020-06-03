# Terraform Module for AWS Lambda

## As a Module

Configure the Lambda function with all required variables:

```hcl
module "lambda" {
  source        = "./modules/lambda"
  create_lambda = true
  description   = "Example Lambda Function"
  function_name = "example123"
  runtime       = "nodejs12.x"
  handler       = "index.my_handler"
  s3_bucket     = "xxxxxxxxxxx"
  s3_key        = "packages/index.zip"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | > 2.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | > 2.14.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_lambda | Do you want to Create Lambda Function | `bool` | `true` | no |
| description | Description of what your Lambda Function does. | `string` | `""` | no |
| environment | Environment (e.g. env variables) configuration for the Lambda function enable you to dynamically pass settings to your function code and libraries | `map(map(string))` | `{}` | no |
| filename | The path to the function's deployment package within the local filesystem. | `string` | `null` | no |
| function\_name | A unique name for your Lambda Function. | `string` | n/a | yes |
| handler | The function entrypoint in your code. | `string` | n/a | yes |
| memory\_size | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. | `number` | `128` | no |
| publish | Whether to publish creation/change as new Lambda Function Version. Defaults to false. | `bool` | `false` | no |
| reserved\_concurrent\_executions | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `string` | `"-1"` | no |
| runtime | The runtime environment for the Lambda function you are uploading. | `string` | n/a | yes |
| s3\_bucket | The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function. | `string` | `null` | no |
| s3\_key | The S3 key of an object containing the function's deployment package. Conflicts with filename. | `string` | `null` | no |
| s3\_object\_version | The object version containing the function's deployment package. Conflicts with filename. | `string` | `null` | no |
| source\_code\_hash | Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key. The usual way to set this is filebase64sha256('file.zip') where 'file.zip' is the local filename of the lambda function source archive. | `string` | `null` | no |
| tags | A mapping of tags to assign to the Lambda function. | `map(string)` | `{}` | no |
| timeout | The amount of time your Lambda Function has to run in seconds. Defaults to 3. | `number` | `30` | no |
| tracing\_config | Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with sampled=1, If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision | `map(string)` | `{}` | no |
| vpc\_config | Provide this to allow your function to access your VPC (if both 'subnet\_ids' and 'security\_group\_ids' are empty then vpc\_config is considered to be empty or unset, see https://docs.aws.amazon.com/lambda/latest/dg/vpc.html for details). | `map(list(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) identifying your Lambda Function. |
| function\_name | The unique name of your Lambda Function. |
| invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| role\_name | The name of the IAM attached to the Lambda Function. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->