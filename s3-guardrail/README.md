# s3-guardrail

Deny bucket and object deletion for everyone but the given principals.

S3 has no tag condition, so the central `Project` tag guardrail cannot cover it.
`PutBucketPolicy` / `DeleteBucketPolicy` are denied too, so the statement cannot be
stripped and the bucket deleted after.

```hcl
module "s3_guardrail" {
  source               = "github.com/teityura/terraform-modules//s3-guardrail"
  bucket_arn           = aws_s3_bucket.site.arn
  allow_principal_arns = [data.aws_caller_identity.current.arn]
}

data "aws_iam_policy_document" "site" {
  source_policy_documents = [module.s3_guardrail.json]

  statement {
    # the bucket's own rules
  }
}
```

| input | |
|---|---|
| `bucket_arn` | bucket to protect |
| `allow_principal_arns` | exempt principals, normally the Terraform caller |
