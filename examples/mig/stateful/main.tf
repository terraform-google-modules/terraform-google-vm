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
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "random_string" "suffix" {
  length  = 4
  special = "false"
  upper   = "false"
}

/** Network **/

resource "google_compute_network" "main" {
  project                 = var.project_id
  name                    = "cft-vm-test-${random_string.suffix.result}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  project       = var.project_id
  region        = var.region
  name          = "cft-vm-test-${random_string.suffix.result}"
  ip_cidr_range = "10.128.0.0/20"
  network       = google_compute_network.main.self_link
}

module "instance_template" {
  source             = "../../../modules/instance_template"
  project_id         = var.project_id
  subnetwork         = var.subnetwork
  service_account    = var.service_account
  subnetwork_project = var.project_id
}

module "mig" {
  source                = "../../../modules/mig"
  project_id            = var.project_id
  region                = var.region
  target_size           = var.target_size
  hostname              = "mig-stateful"
  instance_template     = module.instance_template.self_link
  stateful_internal_ips = [{
    network_interface_name = "nic0"
    delete_rule            = "ON_PERMANENT_INSTANCE_DELETION"
  }]
}

resource "google_compute_region_disk" "default" {
  project_id        = var.project_id
  type              = "pd-ssd"
  zone              = var.region
  image             = "debian-11-bullseye-v20220719"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}