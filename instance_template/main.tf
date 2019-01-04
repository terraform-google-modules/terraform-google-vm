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

data "google_compute_image" "image" {
  project = "${var.source_image != "" ? var.source_image_project : "centos-cloud"}"
  name    = "${var.source_image != "" ? var.source_image : "centos-6-v20180716"}"
}

data "google_compute_image" "image_family" {
  project = "${var.source_image_family != "" ? var.source_image_project : "centos-cloud"}"
  family  = "${var.source_image_family != "" ? var.source_image_family : "centos-6"}"
}

#################
# Boot disk only
#################
resource "google_compute_instance_template" "tpl_0" {
  count        = "${length(var.additional_disks) == 0 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}

####################
# 1 additional disk
####################

resource "google_compute_instance_template" "tpl_1" {
  count        = "${length(var.additional_disks) == 1 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[0], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[0], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[0], "auto_delete")}"
    boot         = false
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}

#####################
# 2 additional disks
#####################
resource "google_compute_instance_template" "tpl_2" {
  count        = "${length(var.additional_disks) == 2 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[0], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[0], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[0], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[1], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[1], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[1], "auto_delete")}"
    boot         = false
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}

#####################
# 3 additional disks
#####################
resource "google_compute_instance_template" "tpl_3" {
  count        = "${length(var.additional_disks) == 3 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[0], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[0], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[0], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[1], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[1], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[1], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[2], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[2], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[2], "auto_delete")}"
    boot         = false
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}

#####################
# 4 additional disks
#####################
resource "google_compute_instance_template" "tpl_4" {
  count        = "${length(var.additional_disks) == 4 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[0], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[0], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[0], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[1], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[1], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[1], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[2], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[2], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[2], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[3], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[3], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[3], "auto_delete")}"
    boot         = false
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}

#####################
# 5 additional disks
#####################
resource "google_compute_instance_template" "tpl_5" {
  count        = "${length(var.additional_disks) == 5 ? 1 : 0}"
  name_prefix  = "${var.name_prefix}-"
  machine_type = "${var.machine_type}"
  labels       = "${var.labels}"
  metadata     = "${var.metadata}"
  tags         = "${var.tags}"

  can_ip_forward = "${var.can_ip_forward}"

  disk {
    source_image = "${var.source_image != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    disk_size_gb = "${var.disk_size_gb}"
    disk_type    = "${var.disk_type}"
    auto_delete  = "${var.auto_delete}"
    boot         = true
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[0], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[0], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[0], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[1], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[1], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[1], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[2], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[2], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[2], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[3], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[3], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[3], "auto_delete")}"
    boot         = false
  }

  disk {
    disk_size_gb = "${lookup(var.additional_disks[4], "disk_size_gb")}"
    disk_type    = "${lookup(var.additional_disks[4], "disk_type")}"
    auto_delete  = "${lookup(var.additional_disks[4], "auto_delete")}"
    boot         = false
  }

  network_interface {
    network            = "${var.network}"
    subnetwork         = "${var.subnetwork}"
    subnetwork_project = "${var.subnetwork_project}"
  }

  service_account = ["${var.service_account}"]

  lifecycle {
    create_before_destroy = true
  }
}
