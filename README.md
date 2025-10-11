# Gemini EventBridge Infrastructure - Terraform

This directory contains Terraform configuration to deploy the Gemini event-driven architecture using AWS EventBridge, SQS, and Lambda.

## Overview

This Terraform configuration replaces the PowerShell scripts (`script-01-setup-eventbridge.ps1` and `create-all.ps1`) with a declarative infrastructure-as-code approach.

### What It Creates

- **1 EventBridge Event Bus**: `gemini`
- **9 EventBridge Rules**: For different event types
- **12 SQS FIFO Queues**: For asynchronous message processing
- **EventBridge Targets**: Connecting rules to SQS queues and Lambda functions
- **Permissions**: SQS queue policies and Lambda permissions for EventBridge

## Prerequisites

1. **Terraform**: Install from [terraform.io](https://www.terraform.io/downloads)
2. **AWS CLI**: Configured with credentials (or LocalStack)
3. **LocalStack** (for local development): Running on `http://localhost:4566`

## Directory Structure

```
terraform/
├── provider.tf              # Provider configuration (AWS/LocalStack)
├── variables.tf             # Variable definitions
├── terraform.tfvars         # Variable values
├── eventbridge.tf           # EventBridge event bus and rules
├── sqs.tf                   # SQS queues and policies
├── lambda.tf                # Lambda function references and permissions
├── eventbridge_targets.tf   # EventBridge rule targets
├── outputs.tf               # Output values
└── README.md               # This file
```

## Usage

### LocalStack (Local Development)

1. **Start LocalStack**:
   ```bash
   docker run -d --name localstack -p 4566:4566 localstack/localstack
   ```

2. **Initialize Terraform**:
   ```powershell
   cd terraform
   terraform init
   ```

3. **Review the plan**:
   ```powershell
   terraform plan
   ```

4. **Apply the configuration**:
   ```powershell
   terraform apply
   ```

5. **View outputs**:
   ```powershell
   terraform output
   ```

### AWS (Production)

1. **Update `terraform.tfvars`**:
   ```hcl
   aws_region      = "us-east-1"  # or your preferred region
   use_localstack  = false
   aws_account_id  = "123456789012"  # your AWS account ID
   ```

2. **Apply**:
   ```powershell
   terraform init
   terraform plan
   terraform apply
   ```

## Commands

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize Terraform and download providers |
| `terraform plan` | Show what changes will be made |
| `terraform apply` | Create/update infrastructure |
| `terraform destroy` | Delete all resources |
| `terraform output` | Show output values |
| `terraform fmt` | Format Terraform files |
| `terraform validate` | Validate configuration |

## Variables

Edit `terraform.tfvars` to customize:

- `aws_region`: AWS region (default: `us-east-1`)
- `use_localstack`: Use LocalStack for local dev (default: `true`)
- `aws_account_id`: AWS account ID (default: `000000000000` for LocalStack)
- `event_bus_name`: EventBridge event bus name (default: `gemini`)
- `lambda_functions`: Map of Lambda function names

## Advantages Over PowerShell Scripts

1. ✅ **Declarative**: Define what you want, not how to create it
2. ✅ **State Management**: Terraform tracks what's deployed
3. ✅ **Idempotent**: Safe to run multiple times
4. ✅ **Plan Before Apply**: See changes before making them
5. ✅ **Dependency Management**: Automatic resource ordering
6. ✅ **Modular**: Easy to add/remove resources
7. ✅ **Version Control**: Track infrastructure changes in Git
8. ✅ **Destroy**: Clean up everything with one command

## Event Flow

```
Event Source → EventBridge Rule → Target (SQS Queue or Lambda)
```

### Events and Targets

| Event Type | Rule Name | Targets |
|------------|-----------|---------|
| OrderSubmitted | OrderSubmittedRule | inventory queue, fulfillment queue |
| InventoryLevelChanged | InventoryLevelChangedRule | catalog queue |
| InventoryReserved | InventoryReservedRule | order queue, fulfillment queue |
| OrderStockFailed | OrderStockFailedRule | order queue |
| FulfillmentTaskCreated | FulfillmentTaskCreatedRule | warehouse queue |
| ShippingJobCreated | ShippingJobCreatedRule | shipping-create Lambda |
| LabelGenerated | LabelGeneratedRule | order queue |
| WarehouseJobCompleted | WarehouseJobCompletedRule | order queue, fulfillment queue |
| JobPickInProgress | JobPickInProgressRule | order queue, fulfillment queue |

## Troubleshooting

### LocalStack Connection Issues
```powershell
# Check if LocalStack is running
curl http://localhost:4566/_localstack/health

# View LocalStack logs
docker logs localstack
```

### Terraform State Issues
```powershell
# Remove state and start fresh (CAUTION: will lose state tracking)
rm -rf .terraform terraform.tfstate*
terraform init
```

### Lambda Function Not Found
Make sure the Lambda function exists before applying. The Terraform config uses `data` sources to reference existing Lambda functions.

## Migrating from PowerShell Scripts

1. ✅ Ensure LocalStack is running
2. ✅ (Optional) Clean up existing resources or let Terraform manage them
3. ✅ Run `terraform apply`
4. ✅ Verify resources in LocalStack:
   ```powershell
   aws --endpoint-url=http://localhost:4566 events list-rules --region us-east-1
   aws --endpoint-url=http://localhost:4566 sqs list-queues --region us-east-1
   ```

## Notes

- All SQS queues are FIFO queues with content-based deduplication enabled
- Lambda functions are referenced via `data` sources (must exist before running Terraform)
- EventBridge permissions are automatically configured for SQS and Lambda targets
