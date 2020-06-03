variable "create_lambda" {
  type        = bool
  description = "Do you want to Create Lambda Function"
  default     = true
}

variable "filename" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
  default     = null
}

variable "function_name" {
  type        = string
  description = "A unique name for your Lambda Function."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function you are uploading."
}

variable "description" {
  type        = string
  description = "Description of what your Lambda Function does."
  default     = ""
}

variable "environment" {
  type        = map(map(string))
  description = "Environment (e.g. env variables) configuration for the Lambda function enable you to dynamically pass settings to your function code and libraries"
  default     = {}
}

variable "memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default     = 128
}

variable "publish" {
  type        = bool
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  default     = false
}

variable "reserved_concurrent_executions" {
  type        = string
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  default     = "-1"
}

variable "s3_bucket" {
  type        = string
  description = "The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function."
  default     = null
}

variable "s3_key" {
  type        = string
  description = " The S3 key of an object containing the function's deployment package. Conflicts with filename."
  default     = null
}

variable "s3_object_version" {
  type        = string
  description = "The object version containing the function's deployment package. Conflicts with filename."
  default     = null
}

variable "source_code_hash" {
  type        = string
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256('file.zip') where 'file.zip' is the local filename of the lambda function source archive."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the Lambda function."
  default     = {}
}

variable "timeout" {
  type        = number
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  default     = 30
}

variable "vpc_config" {
  type        = map(list(string))
  description = "Provide this to allow your function to access your VPC (if both 'subnet_ids' and 'security_group_ids' are empty then vpc_config is considered to be empty or unset, see https://docs.aws.amazon.com/lambda/latest/dg/vpc.html for details)."
  default     = {}
}

variable "tracing_config" {
  type        = map(string)
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with sampled=1, If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision"
  default = {
    mode = "Active"
  }
}
