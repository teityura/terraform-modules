# [NOTE] S3 はタグ条件非対応なので Project タグによる中央ガードレールが効かない
# PutBucketPolicy / DeleteBucketPolicy も拒否し、剥がしてから消す2段削除を防ぐ
data "aws_iam_policy_document" "this" {
  statement {
    sid    = "DenyDelete"
    effect = "Deny"

    actions = [
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:PutBucketPolicy",
    ]

    resources = [var.bucket_arn, "${var.bucket_arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnNotLike"
      variable = "aws:PrincipalArn"
      values   = var.allow_principal_arns
    }
  }
}
