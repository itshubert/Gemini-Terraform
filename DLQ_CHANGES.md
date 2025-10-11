# Dead Letter Queue (DLQ) Configuration Changes

## Overview
This document summarizes the changes made to add Dead Letter Queues (DLQs) to the Gemini Terraform configuration for improved error handling and message recovery.

## Changes Made

### 1. SQS Queue DLQs (`sqs.tf`)
Added a DLQ for each SQS queue to handle messages that fail processing after multiple attempts:

- **Configuration**: Each queue now has a corresponding DLQ with `-dlq` suffix
- **Redrive Policy**: Messages are sent to DLQ after 3 failed processing attempts (`maxReceiveCount: 3`)
- **Retention**: DLQ messages are retained for 14 days (1,209,600 seconds)
- **Queue Type**: All DLQs are FIFO queues matching the main queue configuration

#### SQS Queues with DLQs:
1. `order-submitted-inventory` → `order-submitted-inventory-dlq`
2. `order-submitted-fulfillment` → `order-submitted-fulfillment-dlq`
3. `inventory-level-changed-catalog` → `inventory-level-changed-catalog-dlq`
4. `inventory-reserved-order` → `inventory-reserved-order-dlq`
5. `inventory-reserved-fulfillment` → `inventory-reserved-fulfillment-dlq`
6. `order-stock-failed-order` → `order-stock-failed-order-dlq`
7. `fulfillment-task-created-warehouse` → `fulfillment-task-created-warehouse-dlq`
8. `shipping-labelgenerated-order` → `shipping-labelgenerated-order-dlq`
9. `job-completed-order` → `job-completed-order-dlq`
10. `job-completed-fulfillment` → `job-completed-fulfillment-dlq`
11. `job-pickinprogress-order` → `job-pickinprogress-order-dlq`
12. `job-pickinprogress-fulfillment` → `job-pickinprogress-fulfillment-dlq`

### 2. EventBridge Rule DLQs (`eventbridge_targets.tf`)
Added a DLQ for each EventBridge rule to capture events that fail delivery to targets:

- **Configuration**: One DLQ per EventBridge rule (shared by all targets of that rule)
- **Naming Convention**: `eventbridge-{rule-name}-dlq.fifo`
- **Retention**: DLQ messages are retained for 14 days (1,209,600 seconds)
- **IAM Policies**: Added SQS queue policies allowing EventBridge to send messages to DLQs

#### EventBridge Rules with DLQs:
1. `OrderSubmittedRule` → `eventbridge-order-submitted-dlq`
2. `InventoryLevelChangedRule` → `eventbridge-inventory-level-changed-dlq`
3. `InventoryReservedRule` → `eventbridge-inventory-reserved-dlq`
4. `OrderStockFailedRule` → `eventbridge-order-stock-failed-dlq`
5. `FulfillmentTaskCreatedRule` → `eventbridge-fulfillment-task-created-dlq`
6. `ShippingJobCreatedRule` → `eventbridge-shipping-job-created-dlq`
7. `LabelGeneratedRule` → `eventbridge-label-generated-dlq`
8. `WarehouseJobCompletedRule` → `eventbridge-warehouse-job-completed-dlq`
9. `JobPickInProgressRule` → `eventbridge-job-pick-in-progress-dlq`

### 3. Dead Letter Configuration
All EventBridge targets now include a `dead_letter_config` block that references the appropriate DLQ for their rule.

## Benefits

1. **Error Recovery**: Failed messages are preserved in DLQs for investigation and potential replay
2. **Operational Visibility**: DLQs provide visibility into system failures and processing issues
3. **Message Retention**: Failed messages are retained for 14 days, providing time for analysis
4. **Separate Concerns**: 
   - SQS DLQs handle consumer/processing failures
   - EventBridge DLQs handle delivery failures to targets
5. **Per-Rule Granularity**: Each EventBridge rule has its own DLQ for better isolation and troubleshooting

## Monitoring Recommendations

1. **Set up CloudWatch Alarms** on DLQ message counts to alert when messages land in DLQs
2. **Create CloudWatch Dashboards** to monitor DLQ metrics
3. **Implement automated processes** to analyze and potentially replay messages from DLQs
4. **Regular audits** of DLQ contents to identify recurring issues

## Next Steps

1. Run `terraform plan` to review the changes
2. Run `terraform apply` to create the DLQ resources
3. Set up CloudWatch alarms for DLQ monitoring
4. Document procedures for handling messages in DLQs

## Total Resources Added

- **12 SQS Queue DLQs** (for main queues)
- **9 EventBridge DLQs** (one per rule)
- **9 SQS Queue Policies** (for EventBridge DLQs)

**Total: 30 new resources**
