/**
 * Copyright 2019 Google LLC
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

resource "google_compute_address" "ip_address" {
  name = "external-ip"
}

locals {
  access_config = {
    nat_ip       = google_compute_address.ip_address.address
    network_tier = "PREMIUM"
  }
}

module "instance_template" {
  source          = "../../../modules/instance_template"
  name_prefix     = "${var.hostname}-instance-template"
  machine_type    = var.machine_type
  project_id      = var.project_id
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
  source_image         = var.source_image
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project

  /* disks */
  disk_size_gb     = var.disk_size_gb
  disk_type        = var.disk_type
  auto_delete      = var.auto_delete
  additional_disks = var.additional_disks
}

module "umig" {
  source             = "../../../modules/umig"
  project_id         = var.project_id
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  hostname           = var.hostname
  static_ips         = var.static_ips
  num_instances      = var.target_size
  instance_template  = module.instance_template.self_link
  named_ports        = var.named_ports
  region             = var.region
  access_config      = [[local.access_config]]
}
