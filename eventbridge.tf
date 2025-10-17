# EventBridge Event Bus
resource "aws_cloudwatch_event_bus" "gemini" {
  name = var.event_bus_name
}

# ============================================================================
# EventBridge Rules
# ============================================================================

# Order Submitted Rule
resource "aws_cloudwatch_event_rule" "order_submitted" {
  name           = "OrderSubmittedRule"
  description    = "EventBridge rule for OrderSubmitted event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderSubmitted"]
  })
}

# Inventory Level Changed Rule
resource "aws_cloudwatch_event_rule" "inventory_level_changed" {
  name           = "InventoryLevelChangedRule"
  description    = "EventBridge rule for InventoryLevelChanged event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["InventoryLevelChanged"]
  })
}

# Inventory Reserved Rule
resource "aws_cloudwatch_event_rule" "inventory_reserved" {
  name           = "InventoryReservedRule"
  description    = "EventBridge rule for InventoryReserved event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["InventoryReserved"]
  })
}

# Order Stock Failed Rule
resource "aws_cloudwatch_event_rule" "order_stock_failed" {
  name           = "OrderStockFailedRule"
  description    = "EventBridge rule for OrderStockFailed event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderStockFailed"]
  })
}

# Fulfillment Task Created Rule
resource "aws_cloudwatch_event_rule" "fulfillment_task_created" {
  name           = "FulfillmentTaskCreatedRule"
  description    = "EventBridge rule for FulfillmentTaskCreated event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["FulfillmentTaskCreated"]
  })
}

# Shipping Job Created Rule
resource "aws_cloudwatch_event_rule" "shipping_job_created" {
  name           = "ShippingJobCreatedRule"
  description    = "EventBridge rule for ShippingJobCreated event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["ShippingJobCreated"]
  })
}

# Label Generated Rule
resource "aws_cloudwatch_event_rule" "label_generated" {
  name           = "LabelGeneratedRule"
  description    = "EventBridge rule for LabelGenerated event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["LabelGenerated"]
  })
}

# Warehouse Job Completed Rule
resource "aws_cloudwatch_event_rule" "warehouse_job_completed" {
  name           = "WarehouseJobCompletedRule"
  description    = "EventBridge rule for WarehouseJobCompleted event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["WarehouseJobCompleted"]
  })
}

# Job Pick In Progress Rule
resource "aws_cloudwatch_event_rule" "job_pick_in_progress" {
  name           = "JobPickInProgressRule"
  description    = "EventBridge rule for JobPickInProgress event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["JobPickInProgress"]
  })
}

# Order Shipped Rule
resource "aws_cloudwatch_event_rule" "order_shipped" {
  name           = "OrderShippedRule"
  description    = "EventBridge rule for OrderShipped event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderShipped"]
  })
}

# Order Ready For Shipment Rule
resource "aws_cloudwatch_event_rule" "order_ready_for_shipment" {
  name           = "OrderReadyForShipmentRule"
  description    = "EventBridge rule for OrderReadyForShipment event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderReadyForShipment"]
  })
}

# Order In Progress Rule
resource "aws_cloudwatch_event_rule" "order_in_progress" {
  name           = "OrderInProgressRule"
  description    = "EventBridge rule for OrderInProgress event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderInProgress"]
  })
}

# Order Delivered Rule
resource "aws_cloudwatch_event_rule" "order_delivered" {
  name           = "OrderDeliveredRule"
  description    = "EventBridge rule for OrderDelivered event"
  event_bus_name = aws_cloudwatch_event_bus.gemini.name

  event_pattern = jsonencode({
    source      = ["gemini"]
    detail-type = ["OrderDelivered"]
  })
}
