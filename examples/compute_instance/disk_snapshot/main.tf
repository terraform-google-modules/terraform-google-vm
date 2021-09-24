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

# Building the list of disk names in the required format.
# Usually you would build this list from the outputs of the compute_instance module
locals {
  instance_disks = [for i in range(2) : "projects/${var.project_id}/disks/instance-disk-snapshot-001-${i + 1}/zones/${data.google_compute_zones.available.names[0]}"]
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

module "instance_template" {
  source          = "../../../modules/instance_template"
  region          = var.region
  project_id      = var.project_id
  subnetwork      = var.subnetwork
  name_prefix     = "instance-disk-snapshot"
  service_account = null

  additional_disks = [
    {
      auto_delete  = true
      boot         = false
      disk_size_gb = 20
      disk_type    = "pd-standard"
      disk_name    = null
      device_name  = null
      disk_labels  = { "foo" : "bar" }
    },
    {
      auto_delete  = true
      boot         = false
      disk_size_gb = 30
      disk_type    = "pd-standard"
      disk_name    = null
      device_name  = null
      disk_labels  = {}
    }
  ]
}

module "compute_instance" {
  source            = "../../../modules/compute_instance"
  region            = var.region
  subnetwork        = var.subnetwork
  num_instances     = 1
  hostname          = "instance-disk-snapshot"
  instance_template = module.instance_template.self_link
}

module "disk_snapshots" {
  source  = "../../../modules/compute_disk_snapshot"
  name    = "backup-policy-test"
  project = var.project_id
  region  = var.region

  snapshot_retention_policy = {
    max_retention_days    = 10
    on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
  }

  snapshot_schedule = {
    daily_schedule = {
      days_in_cycle = 1
      start_time    = "08:00"
    }
    hourly_schedule = null
    weekly_schedule = null
  }

  snapshot_properties = {
    guest_flush       = true
    storage_locations = ["EU"]
    labels            = null
  }

  module_depends_on = [module.compute_instance]
  disks             = local.instance_disks
}
