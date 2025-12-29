/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Simple example: Associate a single SSH key with a service account
module "oslogin_single_key" {
  source = "../../modules/oslogin"

  user       = var.service_account_email
  key        = file(var.ssh_public_key_path)
  project_id = var.project_id
}

# Example: Associate SSH keys with multiple service accounts
locals {
  service_accounts = [
    "sa-dev@${var.project_id}.iam.gserviceaccount.com",
    "sa-staging@${var.project_id}.iam.gserviceaccount.com",
    "sa-prod@${var.project_id}.iam.gserviceaccount.com"
  ]
}

module "oslogin_multiple_accounts" {
  source   = "../../modules/oslogin"
  for_each = toset(local.service_accounts)

  user       = each.value
  key        = file(var.ssh_public_key_path)
  project_id = var.project_id
}

# Example: SSH key with expiration time (expires in 90 days from now)
locals {
  ninety_days_from_now_usec = (timeadd(timestamp(), "2160h")) # 90 days * 24 hours
  expiration_usec           = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'", local.ninety_days_from_now_usec)
}

module "oslogin_expiring_key" {
  source = "../../modules/oslogin"

  user       = var.service_account_email
  key        = file(var.ssh_public_key_path)
  project_id = var.project_id
  # Expiration time in microseconds - example: 90 days from now
  # Note: You'll need to calculate this value based on your requirements
  # expiration_time_usec = "1767139200000000"  # Example: 2025-12-31
}
