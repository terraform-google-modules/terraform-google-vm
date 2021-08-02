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

locals {
  hostname      = var.hostname == "" ? "default" : var.hostname
  num_instances = length(var.static_ips) == 0 ? var.num_instances : length(var.static_ips)

  # local.static_ips is the same as var.static_ips with a dummy element appended
  # at the end of the list to work around "list does not have any elements so cannot
  # determine type" error when var.static_ips is empty
  static_ips = concat(var.static_ips, ["NOT_AN_IP"])

  instance_group_count = min(
    local.num_instances,
    length(data.google_compute_zones.available.names),
  )
}

###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
  status  = "UP"
}

#############
# Instances
#############

resource "google_compute_instance_from_template" "compute_instance" {
  provider = google
  count    = local.num_instances
  name     = "${local.hostname}-${format("%03d", count.index + 1)}"
  project  = var.project_id
  zone     = data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    network_ip         = length(var.static_ips) == 0 ? "" : element(local.static_ips, count.index)

    dynamic "access_config" {
      # convert to map to use lookup function with default value
      for_each = lookup({ for k, v in var.access_config : k => v }, count.index, [])
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.network_tier
      }
    }
  }

  dynamic "network_interface" {
    for_each = var.additional_networks
    content {
      network            = network_interface.value.network
      subnetwork         = network_interface.value.subnetwork
      subnetwork_project = network_interface.value.subnetwork_project
      network_ip         = length(network_interface.value.network_ip) > 0 ? network_interface.value.network_ip : null
      dynamic "access_config" {
        for_each = network_interface.value.access_config
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
        }
      }
    }
  }

  source_instance_template = var.instance_template
}

resource "google_compute_instance_group" "instance_group" {
  provider = google
  count    = local.instance_group_count
  name     = "${local.hostname}-instance-group-${format("%03d", count.index + 1)}"
  project  = var.project_id
  zone     = element(data.google_compute_zones.available.names, count.index)
  instances = matchkeys(
    google_compute_instance_from_template.compute_instance.*.self_link,
    google_compute_instance_from_template.compute_instance.*.zone,
    [data.google_compute_zones.available.names[count.index]],
  )

  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }
}

