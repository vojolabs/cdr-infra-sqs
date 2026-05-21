output "sqs_mensagem_bucket_arn" {
  description = "O ARN da fila SQS principal (usado para configurar gatilhos/permissões nas Lambdas)"
  value       = aws_sqs_queue.mensagem_bucket.arn
}

output "sqs_mensagem_bucket_url" {
  description = "A URL da fila SQS principal (usada no código do backend para interagir com a fila)"
  value       = aws_sqs_queue.mensagem_bucket.id
}

output "sqs_mensagem_bucket_name" {
  description = "O nome exato da fila SQS principal criado na AWS"
  value       = aws_sqs_queue.mensagem_bucket.name
}

output "sqs_mensagem_bucket_dlq_arn" {
  description = "O ARN da Fila de Erros (DLQ)"
  value       = aws_sqs_queue.dlq.arn
}

output "sqs_mensagem_bucket_dlq_url" {
  description = "A URL da Fila de Erros (DLQ)"
  value       = aws_sqs_queue.dlq.id
}