# ============================================================================
# SQS Queues - FIFO Queues for Event Processing
# ============================================================================

# Order Submitted Queues
resource "aws_sqs_queue" "order_submitted_inventory" {
  name                        = "order-submitted-inventory.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "order_submitted_fulfillment" {
  name                        = "order-submitted-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Inventory Level Changed Queue
resource "aws_sqs_queue" "inventory_level_changed_catalog" {
  name                        = "inventory-level-changed-catalog.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Inventory Reserved Queues
resource "aws_sqs_queue" "inventory_reserved_order" {
  name                        = "inventory-reserved-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "inventory_reserved_fulfillment" {
  name                        = "inventory-reserved-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Order Stock Failed Queue
resource "aws_sqs_queue" "order_stock_failed_order" {
  name                        = "order-stock-failed-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Fulfillment Task Created Queue
resource "aws_sqs_queue" "fulfillment_task_created_warehouse" {
  name                        = "fulfillment-task-created-warehouse.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Label Generated Queues
resource "aws_sqs_queue" "shipping_labelgenerated_order" {
  name                        = "shipping-labelgenerated-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "shipping_labelgenerated_fulfillment" {
  name                        = "shipping-labelgenerated-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Warehouse Job Completed Queues
resource "aws_sqs_queue" "job_completed_fulfillment" {
  name                        = "job-completed-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Job Pick In Progress Queues
resource "aws_sqs_queue" "job_pickinprogress_fulfillment" {
  name                        = "job-pickinprogress-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Order In Progress Queue
resource "aws_sqs_queue" "fulfillment_orderinprogress_order" {
  name                        = "fulfillment-orderinprogress-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Order Shipped Queue
resource "aws_sqs_queue" "fulfillment_ordershipped_order" {
  name                        = "fulfillment-ordershipped-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Order Ready For Shipment Queue
resource "aws_sqs_queue" "fulfillment_orderreadyforshipment_order" {
  name                        = "fulfillment-orderreadyforshipment-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

# Order Delivered Queues
resource "aws_sqs_queue" "carrier_orderdelivered_fulfillment" {
  name                        = "carrier-orderdelivered-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "carrier_orderdelivered_order" {
  name                        = "carrier-orderdelivered-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}



# ============================================================================
# SQS Queue Policies - Allow EventBridge to Send Messages
# ============================================================================

resource "aws_sqs_queue_policy" "order_submitted_inventory" {
  queue_url = aws_sqs_queue.order_submitted_inventory.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.order_submitted_inventory.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "order_submitted_fulfillment" {
  queue_url = aws_sqs_queue.order_submitted_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.order_submitted_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "inventory_level_changed_catalog" {
  queue_url = aws_sqs_queue.inventory_level_changed_catalog.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.inventory_level_changed_catalog.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "inventory_reserved_order" {
  queue_url = aws_sqs_queue.inventory_reserved_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.inventory_reserved_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "inventory_reserved_fulfillment" {
  queue_url = aws_sqs_queue.inventory_reserved_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.inventory_reserved_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "order_stock_failed_order" {
  queue_url = aws_sqs_queue.order_stock_failed_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.order_stock_failed_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "fulfillment_task_created_warehouse" {
  queue_url = aws_sqs_queue.fulfillment_task_created_warehouse.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.fulfillment_task_created_warehouse.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "shipping_labelgenerated_order" {
  queue_url = aws_sqs_queue.shipping_labelgenerated_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.shipping_labelgenerated_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "shipping_labelgenerated_fulfillment" {
  queue_url = aws_sqs_queue.shipping_labelgenerated_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.shipping_labelgenerated_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "job_completed_fulfillment" {
  queue_url = aws_sqs_queue.job_completed_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.job_completed_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "job_pickinprogress_fulfillment" {
  queue_url = aws_sqs_queue.job_pickinprogress_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.job_pickinprogress_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "fulfillment_orderinprogress_order" {
  queue_url = aws_sqs_queue.fulfillment_orderinprogress_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.fulfillment_orderinprogress_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "fulfillment_ordershipped_order" {
  queue_url = aws_sqs_queue.fulfillment_ordershipped_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.fulfillment_ordershipped_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "fulfillment_orderreadyforshipment_order" {
  queue_url = aws_sqs_queue.fulfillment_orderreadyforshipment_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.fulfillment_orderreadyforshipment_order.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "carrier_orderdelivered_fulfillment" {
  queue_url = aws_sqs_queue.carrier_orderdelivered_fulfillment.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.carrier_orderdelivered_fulfillment.arn
    }]
  })
}

resource "aws_sqs_queue_policy" "carrier_orderdelivered_order" {
  queue_url = aws_sqs_queue.carrier_orderdelivered_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.carrier_orderdelivered_order.arn
    }]
  })
}

