/**
 * Copyright 2018 Google LLC
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

provider "google" {

  project = var.project_id
  region  = var.region
  version = "~> 3.0"
}

resource "google_kms_key_ring" "keyring" {
  count    = var.disk_encryption_key == null ? 1 : 0
  name     = "keyring-example"
  location = "global"
}

resource "google_kms_crypto_key" "example-key" {
  count           = var.disk_encryption_key == null ? 1 : 0
  name            = "crypto-key-example"
  key_ring        = google_kms_key_ring.keyring[0].id
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}

module "instance_template" {
  source          = "../../../modules/instance_template"
  project_id      = var.project_id
  subnetwork      = var.subnetwork
  service_account = var.service_account
  name_prefix     = "additional-disks"

  disk_encryption_key = coalesce(var.disk_encryption_key, google_kms_crypto_key.example-key[0].self_link)

  additional_disks = [
    {
      disk_name           = "disk-0"
      device_name         = "disk-0"
      disk_size_gb        = 10
      disk_type           = "pd-standard"
      auto_delete         = "true"
      boot                = "false"
      disk_labels         = {}
      disk_encryption_key = coalesce(var.disk_encryption_key, google_kms_crypto_key.example-key[0].self_link)
    },
    {
      disk_name           = "disk-1"
      device_name         = "disk-1"
      disk_size_gb        = 10
      disk_type           = "pd-standard"
      auto_delete         = "true"
      boot                = "false"
      disk_labels         = { "foo" : "bar" }
      disk_encryption_key = coalesce(var.disk_encryption_key, google_kms_crypto_key.example-key[0].self_link)
    },
    {
      disk_name           = "disk-2"
      device_name         = "disk-2"
      disk_size_gb        = 10
      disk_type           = "pd-standard"
      auto_delete         = "true"
      boot                = "false"
      disk_labels         = { "foo" : "bar" }
      disk_encryption_key = coalesce(var.disk_encryption_key, google_kms_crypto_key.example-key[0].self_link)
    },
  ]
}
