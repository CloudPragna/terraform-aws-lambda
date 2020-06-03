module "lambda_with_sqs" {
  source        = "../"
  create_lambda = true
  description   = var.description
  function_name = var.function_name
  runtime       = var.runtime
  handler       = var.handler
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  environment = var.environment
  vpc_config = var.vpc_config
  tracing_config = var.tracing_config
  sqs_enable = var.sqs_enable
  sqs_event_source_arn = var.sqs_event_source_arn

}
