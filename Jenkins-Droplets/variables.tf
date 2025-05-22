variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "lon1"
}

variable "tags" {
  description = "Tags for the droplets"
  type        = list(string)
  default     = ["jenkins"]
}

variable "newuser" {
  description = "New user to create on the server"
  type        = string
  default     = "vitae"
}

variable "firewall_name" {
  description = "Name of the firewall"
  type        = string
  default     = "jenkins-server-firewall"
}

variable "ssh_key_name" {
  description = "Name of the SSH key"
  type        = string
  default     = "VITAE-01"
}

variable "droplet_count" {
  description = "Number of droplets to create"
  type        = number
  default     = 1
}

variable "floating_ip_count" {
  description = "Number of floating ips to create"
  type        = number
  default     = 1
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "jenkins-server"
}

variable "image" {
  description = "Droplet image"
  type        = string
  default     = "ubuntu-24-10-x64"
}

variable "size" {
  description = "Droplet size"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
  default     = true
}

variable "enable_backups" {
  description = "Enable backups"
  type        = bool
  default     = false
}

variable "enable_shutdwon" {
  description = "Enable graceful shutdown"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "jenkins-droplets-backup"
}

variable "access_id" {
  description = "DigitalOcean Spaces access ID"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "DigitalOcean Spaces secret key"
  type        = string
  sensitive   = true
}