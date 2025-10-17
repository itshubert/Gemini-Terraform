output "event_bus_name" {
  description = "Name of the EventBridge event bus"
  value       = aws_cloudwatch_event_bus.gemini.name
}

output "event_bus_arn" {
  description = "ARN of the EventBridge event bus"
  value       = aws_cloudwatch_event_bus.gemini.arn
}

output "sqs_queue_urls" {
  description = "URLs of all SQS queues created"
  value = {
    order_submitted_inventory              = aws_sqs_queue.order_submitted_inventory.url
    order_submitted_fulfillment            = aws_sqs_queue.order_submitted_fulfillment.url
    inventory_level_changed_catalog        = aws_sqs_queue.inventory_level_changed_catalog.url
    inventory_reserved_order               = aws_sqs_queue.inventory_reserved_order.url
    inventory_reserved_fulfillment         = aws_sqs_queue.inventory_reserved_fulfillment.url
    order_stock_failed_order               = aws_sqs_queue.order_stock_failed_order.url
    fulfillment_task_created_warehouse     = aws_sqs_queue.fulfillment_task_created_warehouse.url
    shipping_labelgenerated_order          = aws_sqs_queue.shipping_labelgenerated_order.url
    job_completed_fulfillment              = aws_sqs_queue.job_completed_fulfillment.url
    job_pickinprogress_fulfillment         = aws_sqs_queue.job_pickinprogress_fulfillment.url
    fulfillment_orderinprogress_order      = aws_sqs_queue.fulfillment_orderinprogress_order.url
    fulfillment_ordershipped_order         = aws_sqs_queue.fulfillment_ordershipped_order.url
    fulfillment_orderreadyforshipment_order = aws_sqs_queue.fulfillment_orderreadyforshipment_order.url
    carrier_orderdelivered_fulfillment     = aws_sqs_queue.carrier_orderdelivered_fulfillment.url
    carrier_orderdelivered_order           = aws_sqs_queue.carrier_orderdelivered_order.url
  }
}

output "eventbridge_rules" {
  description = "Names of all EventBridge rules created"
  value = [
    aws_cloudwatch_event_rule.order_submitted.name,
    aws_cloudwatch_event_rule.inventory_level_changed.name,
    aws_cloudwatch_event_rule.inventory_reserved.name,
    aws_cloudwatch_event_rule.order_stock_failed.name,
    aws_cloudwatch_event_rule.fulfillment_task_created.name,
    aws_cloudwatch_event_rule.shipping_job_created.name,
    aws_cloudwatch_event_rule.label_generated.name,
    aws_cloudwatch_event_rule.warehouse_job_completed.name,
    aws_cloudwatch_event_rule.job_pick_in_progress.name,
    aws_cloudwatch_event_rule.order_shipped.name,
    aws_cloudwatch_event_rule.order_ready_for_shipment.name,
    aws_cloudwatch_event_rule.order_in_progress.name,
    aws_cloudwatch_event_rule.order_delivered.name,
  ]
}

output "lambda_functions" {
  description = "Details of the Lambda functions"
  value = var.use_localstack || length(var.lambda_functions) > 0 ? {
    shipping_create = {
      function_name = aws_lambda_function.shipping_create[0].function_name
      arn           = aws_lambda_function.shipping_create[0].arn
    }
    shipment_ready = {
      function_name = aws_lambda_function.shipment_ready[0].function_name
      arn           = aws_lambda_function.shipment_ready[0].arn
    }
    shared_role_arn = aws_iam_role.lambda_execution_role[0].arn
  } : null
}
