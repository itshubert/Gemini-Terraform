# ============================================================================
# EventBridge Targets - Connect Rules to SQS Queues and Lambda Functions
# ============================================================================

# Order Submitted Targets
resource "aws_cloudwatch_event_target" "order_submitted_to_inventory" {
  rule           = aws_cloudwatch_event_rule.order_submitted.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-order-submitted-inventory"
  arn            = aws_sqs_queue.order_submitted_inventory.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-submitted"
  }
}

resource "aws_cloudwatch_event_target" "order_submitted_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.order_submitted.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-order-submitted-fulfillment"
  arn            = aws_sqs_queue.order_submitted_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-submitted"
  }
}

# Inventory Level Changed Target
resource "aws_cloudwatch_event_target" "inventory_level_changed_to_catalog" {
  rule           = aws_cloudwatch_event_rule.inventory_level_changed.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-inventory-level-changed-catalog"
  arn            = aws_sqs_queue.inventory_level_changed_catalog.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "inventory-level-changed"
  }
}

# Inventory Reserved Targets
resource "aws_cloudwatch_event_target" "inventory_reserved_to_order" {
  rule           = aws_cloudwatch_event_rule.inventory_reserved.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-inventory-reserved-order"
  arn            = aws_sqs_queue.inventory_reserved_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "inventory-reserved"
  }
}

resource "aws_cloudwatch_event_target" "inventory_reserved_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.inventory_reserved.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-inventory-reserved-fulfillment"
  arn            = aws_sqs_queue.inventory_reserved_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "inventory-reserved"
  }
}

# Order Stock Failed Target
resource "aws_cloudwatch_event_target" "order_stock_failed_to_order" {
  rule           = aws_cloudwatch_event_rule.order_stock_failed.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-order-stock-failed-order"
  arn            = aws_sqs_queue.order_stock_failed_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-stock-failed"
  }
}

# Fulfillment Task Created Target
resource "aws_cloudwatch_event_target" "fulfillment_task_created_to_warehouse" {
  rule           = aws_cloudwatch_event_rule.fulfillment_task_created.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-fulfillment-task-created-warehouse"
  arn            = aws_sqs_queue.fulfillment_task_created_warehouse.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "fulfillment-task-created"
  }
}

# Shipping Job Created Target (Lambda)
resource "aws_cloudwatch_event_target" "shipping_job_created_to_lambda" {
  count          = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  rule           = aws_cloudwatch_event_rule.shipping_job_created.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "lambda-shipping-create"
  arn            = aws_lambda_function.shipping_create[0].arn
  input_path     = "$.detail"
}

# Label Generated Targets
resource "aws_cloudwatch_event_target" "label_generated_to_order" {
  rule           = aws_cloudwatch_event_rule.label_generated.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-labelgenerated-order"
  arn            = aws_sqs_queue.shipping_labelgenerated_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "shipping-labelgenerated"
  }
}

resource "aws_cloudwatch_event_target" "label_generated_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.label_generated.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-labelgenerated-fulfillment"
  arn            = aws_sqs_queue.shipping_labelgenerated_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "shipping-labelgenerated"
  }
}

# Warehouse Job Completed Targets
resource "aws_cloudwatch_event_target" "warehouse_job_completed_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.warehouse_job_completed.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-job-completed-fulfillment"
  arn            = aws_sqs_queue.job_completed_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "job-completed"
  }
}

# Job Pick In Progress Targets
resource "aws_cloudwatch_event_target" "job_pick_in_progress_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.job_pick_in_progress.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-job-pickinprogress-fulfillment"
  arn            = aws_sqs_queue.job_pickinprogress_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "job-pickinprogress"
  }
}

# Order Shipped Target
resource "aws_cloudwatch_event_target" "order_shipped_to_order" {
  rule           = aws_cloudwatch_event_rule.order_shipped.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-ordershipped-order"
  arn            = aws_sqs_queue.fulfillment_ordershipped_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-shipped"
  }
}

# Order Ready For Shipment Target
resource "aws_cloudwatch_event_target" "order_ready_for_shipment_to_order" {
  rule           = aws_cloudwatch_event_rule.order_ready_for_shipment.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-orderreadyforshipment-order"
  arn            = aws_sqs_queue.fulfillment_orderreadyforshipment_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-ready-for-shipment"
  }
}

resource "aws_cloudwatch_event_target" "order_ready_for_shipment_to_lambda" {
  count          = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  rule           = aws_cloudwatch_event_rule.order_ready_for_shipment.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "lambda-shipment-ready"
  arn            = aws_lambda_function.shipment_ready[0].arn
  input_path     = "$.detail"
}

# Order In Progress Target
resource "aws_cloudwatch_event_target" "order_in_progress_to_order" {
  rule           = aws_cloudwatch_event_rule.order_in_progress.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-orderinprogress-order"
  arn            = aws_sqs_queue.fulfillment_orderinprogress_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-in-progress"
  }
}

# Order Delivered Targets
resource "aws_cloudwatch_event_target" "order_delivered_to_fulfillment" {
  rule           = aws_cloudwatch_event_rule.order_delivered.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-orderdelivered-fulfillment"
  arn            = aws_sqs_queue.carrier_orderdelivered_fulfillment.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-delivered"
  }
}

resource "aws_cloudwatch_event_target" "order_delivered_to_order" {
  rule           = aws_cloudwatch_event_rule.order_delivered.name
  event_bus_name = aws_cloudwatch_event_bus.gemini.name
  target_id      = "sqs-orderdelivered-order"
  arn            = aws_sqs_queue.carrier_orderdelivered_order.arn
  input_path     = "$.detail"

  sqs_target {
    message_group_id = "order-delivered"
  }
}