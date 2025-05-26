bucket_region = "us-east-2"

bucket_name = "my-aws-terraform-up-running-state"

resource_super_admin_entity = [
  "arn:aws:iam::650251701142:user/system/Hardarmyyy_MSc_SA_01"
]

mgt_entity = [
  "arn:aws:iam::731670664560:user/system/Hardarmyyy_SA_01",
  "arn:aws:iam::731670664560:role/Management_Administrators_Role"
]

mgt_state_file_bucket_arn = [
  "arn:aws:s3:::my-aws-terraform-up-running-state/global/federation/*"
]