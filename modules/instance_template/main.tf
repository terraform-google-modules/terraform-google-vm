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

###############
# Data Sources
###############
data "google_compute_image" "image" {
  project = "${var.source_image != "" ? var.source_image_project : "centos-cloud"}"
  name    = "${var.source_image != "" ? var.source_image : "centos-6-v20180716"}"
}

data "google_compute_image" "image_family" {
  project = "${var.source_image_family != "" ? var.source_image_project : "centos-cloud"}"
  family  = "${var.source_image_family != "" ? var.source_image_family : "centos-6"}"
}

#########
# Locals
#########

locals {
  boot_disk = [{
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = "true"
  }]

  all_disks = "${concat(local.boot_disk, var.additional_disks)}"
}

####################
# Instance Template
####################
resource "google_compute_instance_template" "tpl" {
  name_prefix             = "${var.name_prefix}-"
  machine_type            = "${var.machine_type}"
  labels                  = "${var.labels}"
  metadata                = "${var.metadata}"
  tags                    = "${var.tags}"
  can_ip_forward          = "${var.can_ip_forward}"
  metadata_startup_script = "${var.startup_script}"
  disk                    = ["${local.all_disks}"]
  service_account         = ["${var.service_account}"]

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  lifecycle {
    create_before_destroy = "true"
  }
}
