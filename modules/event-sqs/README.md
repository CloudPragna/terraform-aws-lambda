# Terraform Module for AWS Lambda

## As a Module

Configure the Lambda function with all required variables:

```hcl
module "event_sqs" {
  source = "./modules/event-sqs"
  enable = true
  batch_size                   = 10
  event_source_mapping_enabled =  true
  function_name                = module.lambda.function_name
  event_source_arn             = lookup(var.event, "event_source_arn", "")
  iam_role_name                = module.lambda.role_name
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| batch\_size | The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 10 for SQS. | `number` | `10` | no |
| enable\_sqs | Conditionally enables this module for SQS events | `bool` | `false` | no |
| event\_source\_arn | Event source ARN of a SQS queue. | `string` | n/a | yes |
| event\_source\_mapping\_enabled | Determines if the mapping will be enabled on creation. Defaults to true. | `bool` | `true` | no |
| function\_name | The name or the ARN of the Lambda function that will be subscribing to events. | `string` | n/a | yes |
| iam\_role\_name | The name of the IAM role to attach stream policy configuration. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->