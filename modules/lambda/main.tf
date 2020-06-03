resource "aws_lambda_function" "this" {
  count       = var.create_lambda ? 1 : 0
  description = var.description
  dynamic "environment" {
    for_each = length(var.environment) > 0 ? [var.environment] : []
    content {
      variables = environment.value.variables
    }
  }
  filename                       = var.filename
  function_name                  = var.function_name
  handler                        = var.handler
  memory_size                    = var.memory_size
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = aws_iam_role.this[0].arn
  runtime                        = var.runtime
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  s3_object_version              = var.s3_object_version
  source_code_hash               = var.source_code_hash
  tags                           = var.tags
  timeout                        = var.timeout

  dynamic "vpc_config" {
    for_each = length(var.vpc_config) > 0 ? [var.vpc_config] : []
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  dynamic "tracing_config" {
    for_each = length(var.tracing_config) > 0 ? [var.tracing_config] : []
    content {
      mode = tracing_config.value.mode
    }
  }


  lifecycle {
    ignore_changes = [
      filename,
      s3_bucket,
      s3_key,
      s3_object_version

    ]
  }

}

data "aws_iam_policy_document" "assume_role_policy" {
  count = var.create_lambda ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.create_lambda ? 1 : 0
  name               = format("%s-lambda-role", var.function_name)
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[0].json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  count      = var.create_lambda ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "vpc_attachment" {
  count      = length(var.vpc_config) > 0 ? 1 : 0
  role       = aws_iam_role.this[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
