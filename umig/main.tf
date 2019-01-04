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

locals {
  hostname             = "${var.hostname == "" ? "default" : var.hostname}"
  instance_group_count = "${min(var.num_instances, length(data.google_compute_zones.available.names))}"
}

###############
# Data Sources
###############

data "google_compute_zones" "available" {}

data "google_compute_image" "image" {
  project = "${var.image_name != "" ? var.img_src_project : "centos-cloud"}"
  name    = "${var.image_name != "" ? var.image_name : "centos-6-v20180716"}"
}

data "google_compute_image" "image_family" {
  project = "${var.image_family != "" ? var.img_src_project : "centos-cloud"}"
  family  = "${var.image_family != "" ? var.image_family : "centos-6"}"
}

#############
# Instances
#############

resource "google_compute_instance" "compute_instance" {
  count        = "${var.num_instances}"
  machine_type = "${var.machine_type}"
  name         = "${local.hostname}-${format("%03d", count.index + 1)}"
  zone         = "${data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]}"

  boot_disk {
    auto_delete = true

    initialize_params {
      size  = "${var.root_volume_size_gb}"
      image = "${var.image_name != "" ? data.google_compute_image.image.self_link : data.google_compute_image.image_family.self_link}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"
    network    = ""

    #address    = "${var.instance_ips[count.index]}"
  }

  metadata = "${var.metadata}"

  service_account {
    email  = "${var.service_account_email}"
    scopes = "${var.service_account_scopes}"
  }

  allow_stopping_for_update = true
  tags                      = "${var.tags}"
  labels                    = "${var.labels}"
}

resource "google_compute_instance_group" "instance_group" {
  count     = "${local.instance_group_count}"
  name      = "${local.hostname}-instance-group-${format("%03d", count.index + 1)}"
  zone      = "${element(data.google_compute_zones.available.names, count.index)}"
  instances = ["${matchkeys(google_compute_instance.compute_instance.*.self_link, google_compute_instance.compute_instance.*.zone, list(data.google_compute_zones.available.names[count.index]))}"]

  named_port = "${var.named_ports}"
}
