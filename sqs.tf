# ============================================================================
# SQS Queues - FIFO Queues for Event Processing
# ============================================================================

# Order Submitted Queues
resource "aws_sqs_queue" "order_submitted_inventory_dlq" {
  name                        = "order-submitted-inventory-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "order_submitted_inventory" {
  name                        = "order-submitted-inventory.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_submitted_inventory_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "order_submitted_fulfillment_dlq" {
  name                        = "order-submitted-fulfillment-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "order_submitted_fulfillment" {
  name                        = "order-submitted-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_submitted_fulfillment_dlq.arn
    maxReceiveCount     = 3
  })
}

# Inventory Level Changed Queue
resource "aws_sqs_queue" "inventory_level_changed_catalog_dlq" {
  name                        = "inventory-level-changed-catalog-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "inventory_level_changed_catalog" {
  name                        = "inventory-level-changed-catalog.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.inventory_level_changed_catalog_dlq.arn
    maxReceiveCount     = 3
  })
}

# Inventory Reserved Queues
resource "aws_sqs_queue" "inventory_reserved_order_dlq" {
  name                        = "inventory-reserved-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "inventory_reserved_order" {
  name                        = "inventory-reserved-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.inventory_reserved_order_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "inventory_reserved_fulfillment_dlq" {
  name                        = "inventory-reserved-fulfillment-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "inventory_reserved_fulfillment" {
  name                        = "inventory-reserved-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.inventory_reserved_fulfillment_dlq.arn
    maxReceiveCount     = 3
  })
}

# Order Stock Failed Queue
resource "aws_sqs_queue" "order_stock_failed_order_dlq" {
  name                        = "order-stock-failed-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "order_stock_failed_order" {
  name                        = "order-stock-failed-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_stock_failed_order_dlq.arn
    maxReceiveCount     = 3
  })
}

# Fulfillment Task Created Queue
resource "aws_sqs_queue" "fulfillment_task_created_warehouse_dlq" {
  name                        = "fulfillment-task-created-warehouse-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "fulfillment_task_created_warehouse" {
  name                        = "fulfillment-task-created-warehouse.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.fulfillment_task_created_warehouse_dlq.arn
    maxReceiveCount     = 3
  })
}

# Label Generated Queues
resource "aws_sqs_queue" "shipping_labelgenerated_order_dlq" {
  name                        = "shipping-labelgenerated-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "shipping_labelgenerated_order" {
  name                        = "shipping-labelgenerated-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shipping_labelgenerated_order_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "shipping_labelgenerated_fulfillment_dlq" {
  name                        = "shipping-labelgenerated-fulfillment-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "shipping_labelgenerated_fulfillment" {
  name                        = "shipping-labelgenerated-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shipping_labelgenerated_fulfillment_dlq.arn
    maxReceiveCount     = 3
  })
}

# Warehouse Job Completed Queues
resource "aws_sqs_queue" "job_completed_order_dlq" {
  name                        = "job-completed-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "job_completed_order" {
  name                        = "job-completed-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.job_completed_order_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "job_completed_fulfillment_dlq" {
  name                        = "job-completed-fulfillment-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "job_completed_fulfillment" {
  name                        = "job-completed-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.job_completed_fulfillment_dlq.arn
    maxReceiveCount     = 3
  })
}

# Job Pick In Progress Queues
resource "aws_sqs_queue" "job_pickinprogress_order_dlq" {
  name                        = "job-pickinprogress-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "job_pickinprogress_order" {
  name                        = "job-pickinprogress-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.job_pickinprogress_order_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "job_pickinprogress_fulfillment_dlq" {
  name                        = "job-pickinprogress-fulfillment-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "job_pickinprogress_fulfillment" {
  name                        = "job-pickinprogress-fulfillment.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.job_pickinprogress_fulfillment_dlq.arn
    maxReceiveCount     = 3
  })
}

# Order Shipped Queue
resource "aws_sqs_queue" "fulfillment_ordershipped_order_dlq" {
  name                        = "fulfillment-ordershipped-order-dlq.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  message_retention_seconds   = 1209600 # 14 days
}

resource "aws_sqs_queue" "fulfillment_ordershipped_order" {
  name                        = "fulfillment-ordershipped-order.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.fulfillment_ordershipped_order_dlq.arn
    maxReceiveCount     = 3
  })
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

resource "aws_sqs_queue_policy" "job_completed_order" {
  queue_url = aws_sqs_queue.job_completed_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.job_completed_order.arn
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

resource "aws_sqs_queue_policy" "job_pickinprogress_order" {
  queue_url = aws_sqs_queue.job_pickinprogress_order.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.job_pickinprogress_order.arn
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

# TODO: Set up CloudWatch alarms to monitor DLQ message counts
# TODO: Create procedures for handling failed messages