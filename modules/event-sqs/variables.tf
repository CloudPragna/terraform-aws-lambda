variable "iam_role_name" {
  type        = string
  description = "The name of the IAM role to attach stream policy configuration."
}

variable "function_name" {
  type        = string
  description = "The name or the ARN of the Lambda function that will be subscribing to events. "
}

variable "event_source_arn" {
  type        = string
  description = "Event source ARN of a SQS queue."
}

variable "batch_size" {
  type        = number
  description = "The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 10 for SQS."
  default     = 10
}

variable "enable_sqs" {
  type        = bool
  description = "Conditionally enables this module for SQS events"
  default     = false
}

variable "event_source_mapping_enabled" {
  type        = bool
  description = "Determines if the mapping will be enabled on creation. Defaults to true."
  default     = true

}
