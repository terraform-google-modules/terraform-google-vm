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

data "google_client_config" "default" {
}

provider "google" {
  version = "~> 3.25"
  region = "us-west1"
}
provider "google-beta" {
  version = "~> 3.25"
  region  = "us-west1"
}

terraform {
  backend "gcs" {
  }
}

data "google_compute_image" "debian" {
  family  = "debian-9"
  project = "debian-cloud"
}


module "instance_template" {
  source          = "../../../modules/instance_template"
  name_prefix     = "${var.hostname}-instance-template"
  project_id      = var.project_id
  region          = var.region
  machine_type    = var.machine_type
  tags            = var.tags
  labels          = var.labels
  startup_script  = var.startup_script
  metadata        = var.metadata
  service_account = var.service_account

  /* network */
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  can_ip_forward     = var.can_ip_forward

  /* image */
  source_image_family  = data.google_compute_image.debian.family
  source_image_project = data.google_compute_image.debian.project

  /* disks */
  disk_size_gb     = var.disk_size_gb
  disk_type        = var.disk_type
  auto_delete      = var.auto_delete
  additional_disks = var.additional_disks
}

module "mig" {
  source                    = "../../../modules/mig"
  project_id                = var.project_id
  network                   = var.network
  subnetwork                = var.subnetwork
  subnetwork_project        = var.subnetwork_project
  hostname                  = var.hostname
  region                    = var.region
  instance_template         = module.instance_template.self_link
  target_size               = var.target_size
  target_pools              = var.target_pools
  distribution_policy_zones = var.zones
  update_policy             = var.update_policy
  named_ports               = var.named_ports

  /* health check */
  health_check = var.health_check

  /* stateful options */
  stateful_enabled     = var.stateful_enabled
  stateful_nodes_count = var.stateful_nodes_count
  stateful_disk_size   = var.stateful_disk_size
  stateful_disk_type   = var.stateful_disk_type
}