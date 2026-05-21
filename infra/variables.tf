###########################################################################################
#  NÃO REMOVER OU SUBSTITUIR ESSAS VARIÁVEIS
# Essas variáveis são essenciais para o deploy e devem existir em todos os ambientes.
# Elas permitem que o template seja configurado dinamicamente via arquivos de variável.
###########################################################################################

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

###########################################################################################
#
###########################################################################################
variable "sqs_mensagem_bucket_name" {
  description = "Nome da fila principal SQS"
  type        = string
  default     = "sqs_mensagem_bucket"
}

variable "sqs_mensagem_bucket_dlq_name" {
  description = "Nome da DLQ da fila principal SQS"
  type        = string
  default     = "sqs_mensagem_bucket_dlq"
}
