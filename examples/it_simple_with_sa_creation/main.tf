/**
 * Copyright 2025 Google LLC
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
  region  = "us-central1"
}

resource "google_compute_address" "ip_address" {
  name = "external-ip"
}

locals {
  access_config = {
    nat_ip       = google_compute_address.ip_address.address
    network_tier = "PREMIUM"
  }
}

resource "random_string" "suffix" {
  length  = 4
  special = "false"
  upper   = "false"
}

resource "google_compute_network" "main" {
  project                 = var.project_id
  name                    = "cft-vm-test-${random_string.suffix.result}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  project       = var.project_id
  region        = "us-central1"
  name          = "cft-vm-test-${random_string.suffix.result}"
  ip_cidr_range = "10.128.0.0/20"
  network       = google_compute_network.main.self_link
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 14.0"

  project_id  = var.project_id
  region      = "us-central1"
  subnetwork  = google_compute_subnetwork.main.self_link
  stack_type  = "IPV4_ONLY"
  name_prefix = "it-simple-sa"
  tags        = ["foo", "bar", "sa"]
  labels = {
    environment = "dev"
  }
  access_config                 = [local.access_config]
  enable_nested_virtualization  = false
  threads_per_core              = null
  service_account_project_roles = ["roles/compute.admin"]
}
