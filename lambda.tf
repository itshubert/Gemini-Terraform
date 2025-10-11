# ============================================================================
# Lambda Function Resource - Create the shipping-create function
# ============================================================================

resource "aws_lambda_function" "shipping_create" {
  count            = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  filename         = "shipping-lambda.zip"
  function_name    = var.lambda_functions.shipping_create
  role             = aws_iam_role.lambda_execution_role[0].arn
  handler          = "src.lambda_function.handler"
  source_code_hash = filebase64sha256("shipping-lambda.zip")
  runtime          = "python3.11"
  timeout          = 30

  environment {
    variables = {
      NODE_ENV         = var.use_localstack ? "development" : "production"
      PGHOST           = "postgres"
      PGPORT           = "5432"
      PGDATABASE       = "geminishipping"
      PGUSER           = "postgres"
      PGPASSWORD       = "Blackbox57!"
      TRACKING_PREFIX  = "N"
      TRACKING_LENGTH  = "5"
      AWS_REGION       = "us-east-1"
      AWS_ENDPOINT_URL = "http://localstack:4566"
      EVENT_BUS_NAME   = var.event_bus_name
      EVENT_SOURCE     = "gemini"
    }
  }

  tags = {
    Environment = var.use_localstack ? "development" : "production"
    Project     = "gemini"
  }
}

# ============================================================================
# IAM Role for Lambda Execution
# ============================================================================

resource "aws_iam_role" "lambda_execution_role" {
  count = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  name  = "shipping-create-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  count      = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role[0].name
}

# IAM Policy for EventBridge PutEvents
resource "aws_iam_role_policy" "lambda_eventbridge_policy" {
  count = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  name  = "shipping-create-eventbridge-policy"
  role  = aws_iam_role.lambda_execution_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "events:PutEvents"
        ]
        Resource = aws_cloudwatch_event_bus.gemini.arn
      }
    ]
  })
}

# ============================================================================
# Lambda Permissions - Allow EventBridge to Invoke Lambda Functions
# ============================================================================

resource "aws_lambda_permission" "eventbridge_invoke_shipping_create" {
  count         = var.use_localstack || length(var.lambda_functions) > 0 ? 1 : 0
  statement_id  = "AllowEventBridgeInvokeShippingCreate"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.shipping_create[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.shipping_job_created.arn
}
