variable "bucket_arn" {
  description = "保護対象のバケット ARN"
  type        = string
}

variable "allow_principal_arns" {
  description = "この Deny から除外するプリンシパル。通常は Terraform 実行者"
  type        = list(string)
}
