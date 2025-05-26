output "s3_terraform_state_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "Terraform state file S3 bucket ARN"
}

output "mgt_entities_to_s3_bucket_policy" {
  value = [
    var.mgt_entity,
  ]
  description = "Allowed entities to s3 bucket policy from management account"
}

output "s3_terraform_state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Terraform state file S3 bucket name"
}