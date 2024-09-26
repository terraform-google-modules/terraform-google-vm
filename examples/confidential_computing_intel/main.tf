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

locals {
  default_suffix = var.suffix == "" ? random_string.suffix.result : "${random_string.suffix.result}-${var.suffix}"
  key_name       = "${var.key}-${local.default_suffix}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "3.0.0"

  keyring              = "${var.keyring}-${local.default_suffix}"
  location             = var.location
  project_id           = var.project_id
  keys                 = [local.key_name]
  purpose              = "ENCRYPT_DECRYPT"
  key_protection_level = "HSM"
  prevent_destroy      = false
}

resource "google_service_account" "default" {
  project      = var.project_id
  account_id   = "confidential-compute-sa"
  display_name = "Custom SA for confidential VM Instance"
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = toset(var.service_account_roles)

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.default.email}"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = module.kms.keys[local.key_name]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com",
  ]
}

module "instance_template" {
  source = "../../modules/instance_template"

  region     = var.region
  project_id = var.project_id
  subnetwork = var.subnetwork

  name_prefix                = "confidential-intel-encrypted"
  source_image_project       = "tdx-guest-images"
  source_image               = "ubuntu-2204-lts"
  disk_type                  = "pd-ssd"
  machine_type               = "c3-standard-4"
  min_cpu_platform           = "Intel Sapphire Rapids"
  enable_confidential_vm     = true
  confidential_instance_type = "TDX"

  service_account = {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  disk_encryption_key = module.kms.keys[local.key_name]
}

module "compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "~> 12.0"

  region              = var.region
  subnetwork          = var.subnetwork
  hostname            = "confidential-intel-encrypted"
  instance_template   = module.instance_template.self_link
  deletion_protection = false
}
