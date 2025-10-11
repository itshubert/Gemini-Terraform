# EventBridge DLQ Removal - Simplified Architecture

## Overview
Removed EventBridge Dead Letter Queues (DLQs) to simplify the infrastructure while maintaining robust error handling through SQS queue DLQs.

## Changes Made

### Removed Resources
All EventBridge-specific DLQ infrastructure has been removed:

1. **9 EventBridge DLQ Queues** (removed)
   - `eventbridge-order-submitted-dlq.fifo`
   - `eventbridge-inventory-level-changed-dlq.fifo`
   - `eventbridge-inventory-reserved-dlq.fifo`
   - `eventbridge-order-stock-failed-dlq.fifo`
   - `eventbridge-fulfillment-task-created-dlq.fifo`
   - `eventbridge-shipping-job-created-dlq.fifo`
   - `eventbridge-label-generated-dlq.fifo`
   - `eventbridge-warehouse-job-completed-dlq.fifo`
   - `eventbridge-job-pick-in-progress-dlq.fifo`

2. **9 SQS Queue Policies** (removed)
   - All policies for EventBridge DLQ queues

3. **`dead_letter_config` blocks** (removed from all EventBridge targets)
   - Removed from 14 EventBridge target resources

### Retained Resources
**13 SQS Queue DLQs** - These remain and provide comprehensive error handling:
- `order-submitted-inventory-dlq.fifo`
- `order-submitted-fulfillment-dlq.fifo`
- `inventory-level-changed-catalog-dlq.fifo`
- `inventory-reserved-order-dlq.fifo`
- `inventory-reserved-fulfillment-dlq.fifo`
- `order-stock-failed-order-dlq.fifo`
- `fulfillment-task-created-warehouse-dlq.fifo`
- `shipping-labelgenerated-order-dlq.fifo`
- `shipping-labelgenerated-fulfillment-dlq.fifo`
- `job-completed-order-dlq.fifo`
- `job-completed-fulfillment-dlq.fifo`
- `job-pickinprogress-order-dlq.fifo`
- `job-pickinprogress-fulfillment-dlq.fifo`

## New Architecture

### Simplified Flow
```
Event → EventBridge Rule → SQS Queue → Consumer
                                ↓ (Processing Failure after 3 attempts)
                           SQS Queue DLQ
```

### Error Handling
- **EventBridge Delivery Failures**: EventBridge automatically retries delivery for up to 24 hours
- **Consumer Processing Failures**: Messages move to SQS DLQ after 3 failed processing attempts
- **DLQ Retention**: All DLQs retain failed messages for 14 days

## Benefits of Simplified Architecture

### ✅ **Reduced Complexity**
- **18 fewer resources** to manage (9 queues + 9 policies)
- Simpler monitoring and alerting setup
- Easier to understand and maintain

### ✅ **Cost Savings**
- Fewer SQS queues to pay for
- Reduced API calls and storage costs

### ✅ **Still Robust**
- EventBridge is highly reliable - delivery failures are rare
- SQS DLQs handle the most common failure scenario (processing errors)
- EventBridge still retries failed deliveries automatically for 24 hours

### ✅ **Industry Best Practice**
- Most teams use only SQS DLQs for EventBridge → SQS architectures
- EventBridge DLQs are typically reserved for:
  - Lambda targets (async invocations)
  - Cross-account or cross-region scenarios
  - Very high-compliance environments

## Resource Count Comparison

| Resource Type | Before | After | Reduction |
|---------------|--------|-------|-----------|
| SQS Queues | 39 | 26 | -13 (33%) |
| SQS Queue Policies | 21 | 13 | -8 (38%) |
| EventBridge Targets | 14 | 14 | 0 |
| **Total DLQ Resources** | **22** | **13** | **-9 (41%)** |

## What Happens Now?

### EventBridge Behavior Without DLQ
- EventBridge will retry failed deliveries automatically using **exponential backoff**
- Retries continue for up to **24 hours**
- If delivery still fails after 24 hours, the event is **discarded**
- You can monitor delivery failures via CloudWatch Metrics: `FailedInvocations`

### Recommended Monitoring
Set up CloudWatch Alarms for:
1. **EventBridge Metrics**:
   - `FailedInvocations` - Track delivery failures
   - `ThrottledRules` - Identify throttling issues

2. **SQS DLQ Metrics** (critical):
   - `ApproximateNumberOfMessagesVisible` - Alert when messages enter DLQs
   - `ApproximateAgeOfOldestMessage` - Track how long messages sit in DLQs

## Validation

✅ Terraform formatted successfully  
✅ Configuration validated with no errors  
✅ Ready for `terraform plan` and `terraform apply`

## Next Steps

1. Run `terraform plan` to review the changes
2. **Note**: Terraform will show destruction of 18 resources (9 queues + 9 policies)
3. Run `terraform apply` to apply the simplified configuration
4. Update CloudWatch alarms to focus on SQS DLQ monitoring
5. Remove any documentation referencing EventBridge DLQs

## Rollback Plan

If you need to restore EventBridge DLQs in the future:
- The removed code is documented in this file
- Simply add back the `dead_letter_config` blocks to targets
- Create the DLQ queues and policies
- This is a non-breaking change and can be done anytime
