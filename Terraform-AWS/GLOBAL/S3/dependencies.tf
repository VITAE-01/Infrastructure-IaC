data "aws_iam_policy_document" "s3_bucket_policy" {

  statement {
    sid    = "DenyS3ActionsForSuperAdminOnManagementStateFileBucket"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = var.resource_super_admin_entity
    }
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = var.mgt_state_file_bucket_arn
  }

  statement {
    sid    = "AllowManagementAccountAccessToManagementStateFileBucket"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.mgt_entity
    }
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = var.mgt_state_file_bucket_arn
  }
}