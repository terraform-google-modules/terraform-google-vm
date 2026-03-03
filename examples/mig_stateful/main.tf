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
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 14.0"

  project_id         = var.project_id
  region             = var.region
  subnetwork         = var.subnetwork
  service_account    = var.service_account
  subnetwork_project = var.project_id
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 14.0"

  project_id        = var.project_id
  region            = var.region
  target_size       = var.target_size
  hostname          = "mig-stateful"
  instance_template = module.instance_template.self_link
  stateful_ips = [{
    interface_name = "nic0"
    delete_rule    = "ON_PERMANENT_INSTANCE_DELETION"
    is_external    = true
  }]

  update_policy = [{
    max_surge_fixed                = 0
    instance_redistribution_type   = "NONE"
    max_surge_percent              = null
    max_unavailable_fixed          = 4
    max_unavailable_percent        = null
    min_ready_sec                  = 180
    replacement_method             = "RECREATE"
    minimal_action                 = "REFRESH"
    type                           = "OPPORTUNISTIC"
    most_disruptive_allowed_action = "REFRESH"
  }]
}
