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

####################
# Instance Templates
####################

module "preemptible" {
  source               = "../../modules/instance_template"
  name_prefix          = "${var.name_prefix}-preemptible"
  project_id           = var.project_id
  machine_type         = var.machine_type
  labels               = var.labels
  metadata             = var.metadata
  tags                 = var.tags
  can_ip_forward       = var.can_ip_forward
  startup_script       = var.startup_script
  source_image         = var.source_image
  source_image_project = var.source_image_project
  source_image_family  = var.source_image_family
  disk_size_gb         = var.disk_size_gb
  disk_type            = var.disk_type
  auto_delete          = var.auto_delete
  additional_disks     = var.additional_disks
  service_account      = var.service_account
  network              = var.network
  subnetwork           = var.subnetwork
  subnetwork_project   = var.subnetwork_project
  access_config        = var.access_config
  preemptible          = true
}

module "regular" {
  source               = "../../modules/instance_template"
  name_prefix          = "${var.name_prefix}-regular"
  project_id           = var.project_id
  machine_type         = var.machine_type
  labels               = var.labels
  metadata             = var.metadata
  tags                 = var.tags
  can_ip_forward       = var.can_ip_forward
  startup_script       = var.startup_script
  source_image         = var.source_image
  source_image_project = var.source_image_project
  source_image_family  = var.source_image_family
  disk_size_gb         = var.disk_size_gb
  disk_type            = var.disk_type
  auto_delete          = var.auto_delete
  additional_disks     = var.additional_disks
  service_account      = var.service_account
  network              = var.network
  subnetwork           = var.subnetwork
  subnetwork_project   = var.subnetwork_project
  access_config        = var.access_config
  preemptible          = false
}
