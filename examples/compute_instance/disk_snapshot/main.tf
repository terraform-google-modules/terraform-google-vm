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

  version = "~> 3.0"
}

locals {
  instance_disks = [for i in range(length(var.additional_disks)) : "projects/${var.project_id}/disks/instance-simple-001-${i + 1}/zones/${data.google_compute_zones.available.names[0]}"]
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

module "instance_template" {
  source           = "../../../modules/instance_template"
  region           = var.region
  project_id       = var.project_id
  subnetwork       = var.subnetwork
  service_account  = var.service_account
  additional_disks = var.additional_disks
}

module "compute_instance" {
  source            = "../../../modules/compute_instance"
  region            = var.region
  subnetwork        = var.subnetwork
  num_instances     = var.num_instances
  hostname          = "instance-simple"
  instance_template = module.instance_template.self_link
  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}

module "disk_snapshots" {
  source  = "../../../modules/compute_disk_snapshot"
  name    = "backup-policy-test"
  project = var.project_id
  region  = var.region

  snapshot_schedule_policy = [{
    retention_policy = [
      {
        max_retention_days    = 10
        on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
      }
    ]

    schedule = [
      {
        daily_schedule = [{
          days_in_cycle = 1
          start_time    = "08:00"
        }]

        hourly_schedule = []
        weekly_schedule = []
      }
    ]

    snapshot_properties = [
      {
        guest_flush       = true
        storage_locations = ["EU"]
        labels            = null
      }
    ]
  }]

  module_depends_on = [module.compute_instance]
  disks             = local.instance_disks
}
