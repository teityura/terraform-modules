output "json" {
  description = "バケットポリシーに source_policy_documents で合成する"
  value       = data.aws_iam_policy_document.this.json
}
