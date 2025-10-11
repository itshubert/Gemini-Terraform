variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "use_localstack" {
  description = "Whether to use LocalStack for local development"
  type        = bool
  default     = true
}

variable "aws_account_id" {
  description = "AWS Account ID (use 000000000000 for LocalStack)"
  type        = string
  default     = "000000000000"
}

variable "event_bus_name" {
  description = "Name of the EventBridge event bus"
  type        = string
  default     = "gemini"
}

variable "lambda_functions" {
  description = "Map of Lambda function names that already exist"
  type        = map(string)
  default = {
    shipping_create = "shipping-create"
  }
}
