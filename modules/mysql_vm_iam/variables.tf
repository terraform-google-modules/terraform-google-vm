variable "project_id" {
  type        = string
  description = "The GCP Project ID for the instances."
}

variable "service_account" {
  type        = string
  description = "Service account to be used for taking snapshots"
}

variable "iam_dba_email" {
  type        = string
  description = "IAM format of the DBA Group Email in Gsuite"
}

variable "instance_zones" {
  type        = list(string)
  description = "List of zones for each hostname"
}

variable "instance_hostnames" {
  type        = list(string)
  description = "List of hostnames"
}

variable "instance_ips" {
  type        = list(string)
  description = "List of IP addresses"
  default     = []
}

variable "secrets" {
  type        = list(string)
  description = "IDs of Secrets Manager secrets that contain backup user credentials"
  default     = []
}

variable "iap_accessor_iam" {
  type        = string
  description = "IAM Email of the group that can access the instances via IAP"
  default     = null
}
