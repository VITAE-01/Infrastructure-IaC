terraform {

  backend "s3" {
    endpoints = {
      s3 = "https://lon1.digitaloceanspaces.com"
    }

    bucket = "jenkins-droplets-backup"
    key    = "global/vitae/jenkins/terraform.tfstate"

    # Deactivate a few AWS-specific checks
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "us-east-2"
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token             = var.do_token
  spaces_access_id  = var.access_id
  spaces_secret_key = var.secret_key
}