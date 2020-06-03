module "lambda" {
  source                         = "./modules/lambda"
  create_lambda                  = var.create_lambda
  filename                       = var.filename
  function_name                  = var.function_name
  handler                        = var.handler
  runtime                        = var.runtime
  description                    = var.description
  environment                    = var.environment
  memory_size                    = var.memory_size
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  source_code_hash               = var.source_code_hash
  tags                           = var.tags
  timeout                        = var.timeout
  vpc_config                     = var.vpc_config
  tracing_config                 = var.tracing_config
}

module "event_sqs" {
  source                       = "./modules/event-sqs"
  enable                       = var.sqs_enable
  batch_size                   = var.sqs_batch_size
  event_source_mapping_enabled = var.sqs_event_source_mapping_enabled
  function_name                = module.lambda.function_name
  event_source_arn             = var.sqs_event_source_arn
  iam_role_name                = module.lambda.role_name
}
