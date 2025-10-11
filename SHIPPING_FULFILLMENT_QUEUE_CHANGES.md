# Shipping Label Generated Fulfillment Queue Changes

## Overview
Added a new SQS queue `shipping-labelgenerated-fulfillment.fifo` as an additional target for the `ShippingJobCreatedRule` EventBridge rule.

## Changes Made

### 1. New SQS Queues (`sqs.tf`)

#### Main Queue
- **Name**: `shipping-labelgenerated-fulfillment.fifo`
- **Type**: FIFO queue with content-based deduplication
- **DLQ**: `shipping-labelgenerated-fulfillment-dlq.fifo`
- **Max Receive Count**: 3 (messages sent to DLQ after 3 failed attempts)

#### Dead Letter Queue
- **Name**: `shipping-labelgenerated-fulfillment-dlq.fifo`
- **Type**: FIFO queue with content-based deduplication
- **Retention**: 14 days (1,209,600 seconds)

### 2. SQS Queue Policy (`sqs.tf`)
Added IAM policy allowing EventBridge to send messages to the new queue:
- **Resource**: `aws_sqs_queue_policy.shipping_labelgenerated_fulfillment`
- **Principal**: `events.amazonaws.com`
- **Action**: `sqs:SendMessage`

### 3. EventBridge Target (`eventbridge_targets.tf`)
Added new target to `ShippingJobCreatedRule`:
- **Target ID**: `sqs-shipping-labelgenerated-fulfillment`
- **Target Type**: SQS Queue
- **Input Path**: `$.detail`
- **Message Group ID**: `shipping-job-created`
- **DLQ**: Uses the existing `eventbridge-shipping-job-created-dlq`

## EventBridge Rule: ShippingJobCreatedRule

This rule now has **two targets**:

1. **Lambda Function** (conditional - only if lambda_functions configured):
   - Target: `aws_lambda_function.shipping_create`
   - Target ID: `lambda-shipping-create`

2. **SQS Queue** (new):
   - Target: `aws_sqs_queue.shipping_labelgenerated_fulfillment`
   - Target ID: `sqs-shipping-labelgenerated-fulfillment`

Both targets share the same EventBridge DLQ for delivery failures.

## Architecture

```
ShippingJobCreated Event
        |
        v
ShippingJobCreatedRule (EventBridge)
        |
        +---> Lambda: shipping_create (if configured)
        |           |
        |           +---> On delivery failure --> eventbridge-shipping-job-created-dlq
        |
        +---> SQS: shipping-labelgenerated-fulfillment.fifo
                    |
                    +---> On delivery failure --> eventbridge-shipping-job-created-dlq
                    +---> On processing failure (3x) --> shipping-labelgenerated-fulfillment-dlq.fifo
```

## Total Resources Added

- **2 SQS Queues** (main queue + DLQ)
- **1 SQS Queue Policy** (for EventBridge permissions)
- **1 EventBridge Target** (connecting rule to queue)

**Total: 4 new resources**

## Validation

✅ Terraform formatting applied successfully
✅ Configuration validated with no errors

## Next Steps

1. Review changes with `terraform plan`
2. Apply changes with `terraform apply`
3. Set up CloudWatch alarms for the new DLQ
4. Update application consumers to process messages from the new queue
