resource "aws_lambda_event_source_mapping" "stream_source" {
  count            = var.enable ? 1 : 0
  batch_size       = var.batch_size
  enabled          = var.event_source_mapping_enabled
  event_source_arn = var.event_source_arn
  function_name    = var.function_name
}

data "aws_iam_policy_document" "stream_policy_document" {
  count = var.enable ? 1 : 0
  statement {
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage"
    ]

    resources = [
      var.event_source_arn
    ]
  }
}

resource "aws_iam_policy" "stream_policy" {
  count       = var.enable ? 1 : 0
  name        = format("%s-lambda-queue-poller", var.function_name)
  description = format("Gives permission to poll a SQS queue to %s.", var.function_name)
  policy      = data.aws_iam_policy_document.stream_policy_document[0].json
}

resource "aws_iam_role_policy_attachment" "stream_policy_attachment" {
  count      = var.enable ? 1 : 0
  role       = var.iam_role_name
  policy_arn = aws_iam_policy.stream_policy[0].arn
}
