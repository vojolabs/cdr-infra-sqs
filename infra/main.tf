data "aws_caller_identity" "current" {}

# 1. Recurso da Dead-Letter Queue (DLQ)
resource "aws_sqs_queue" "dlq" {
  name                      = var.sqs_mensagem_bucket_dlq_name
  message_retention_seconds = 345600 # 4 dias
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

# 2. Fila SQS principal incluindo a DLQ
resource "aws_sqs_queue" "mensagem_bucket" {
  name                       = var.sqs_mensagem_bucket_name
  visibility_timeout_seconds = 60
  message_retention_seconds  = 345600 # 4 dias
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

# 3. Política de acesso à fila (CORRIGIDA)
resource "aws_sqs_queue_policy" "mensagem_bucket_policy" {
  queue_url = aws_sqs_queue.mensagem_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowAnyS3ToPublishMessages",
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action   = "sqs:SendMessage",
        Resource = aws_sqs_queue.mensagem_bucket.arn,
        
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}