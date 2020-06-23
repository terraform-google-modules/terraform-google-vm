/**
 * Copyright 2020 Google LLC
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

  region  = var.region
  version = "~> 3.0"
}

provider "google-beta" {

  region  = var.region
  version = "~> 3.0"
}

module "instance_template" {
  source             = "../../../modules/instance_template"
  project_id         = var.project_id
  subnetwork         = var.subnetwork
  service_account    = var.service_account
  subnetwork_project = var.project_id
}

module "mig" {
  source                    = "../../../modules/mig"
  project_id                = var.project_id
  region                    = var.region
  target_size               = 0
  hostname                  = "mig-simple"
  instance_template         = module.instance_template.self_link
  distribution_policy_zones = var.distribution_policy_zones
  update_policy = [{
    instance_redistribution_type = "NONE"
    type                         = "OPPORTUNISTIC"
    minimal_action               = "RESTART"
    max_surge_fixed              = 2
    max_surge_percent            = null
    max_unavailable_fixed        = 2
    max_unavailable_percent      = null
    min_ready_sec                = null
  }]
}

resource "google_compute_region_disk" "instance_1_data" {
  project       = var.project_id
  name          = "instance-1-data"
  type          = "pd-standard"
  size          = 100
  region        = var.region
  replica_zones = var.distribution_policy_zones
}

resource "google_compute_region_disk" "instance_2_data" {
  project       = var.project_id
  name          = "instance-2-data"
  type          = "pd-standard"
  size          = 100
  region        = var.region
  replica_zones = var.distribution_policy_zones
}

module "stateful_config" {
  source     = "../../../modules/stateful_config"
  project_id = var.project_id
  region     = var.region
  mig_name   = module.mig.name
  names      = ["instance-1", "instance-2"]
  stateful_disks = {
    instance-1 = [
      {
        device_name = "opt"
        source      = google_compute_region_disk.instance_1_data.self_link
        delete_rule = "NEVER"
        mode        = "READ_WRITE"
      }
    ]
    instance-2 = [
      {
        device_name = "opt"
        source      = google_compute_region_disk.instance_2_data.self_link
        delete_rule = "NEVER"
        mode        = "READ_WRITE"
      }
    ]
  }
  stateful_metadata = {
    instance-1 = {
      custom_metadata_key = "instance-1-value"
    }
    instance-2 = {
      custom_metadata_key = "instance-2-value"
    }
  }
}
