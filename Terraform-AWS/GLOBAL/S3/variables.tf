variable "bucket_region" {
  type        = string
  description = "The AWS region where the S3 bucket will be created"
  default     = "us-east-2"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to be created for storing Terraform state files"
  default     = "my-aws-terraform-up-running-state"
}

variable "resource_super_admin_entity" {
  type        = list(string)
  description = "List of users, roles, or entities from AWS resource accounts that have super admin access to the S3 bucket policy"
}

variable "mgt_entity" {
  type        = list(string)
  description = "List of users, roles, or entities from the management account that have access to the S3 bucket policy"
}

variable "mgt_state_file_bucket_arn" {
  type        = list(string)
  description = "The management state file bucket ARN where Terraform state files are stored"
}