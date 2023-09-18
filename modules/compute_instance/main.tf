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
  hostname      = var.hostname == "" ? "default" : var.hostname
  num_instances = length(var.static_ips) == 0 ? var.num_instances : length(var.static_ips)

  # local.static_ips is the same as var.static_ips with a dummy element appended
  # at the end of the list to work around "list does not have any elements so cannot
  # determine type" error when var.static_ips is empty
  static_ips = concat(var.static_ips, ["NOT_AN_IP"])
  project_id = length(regexall("/projects/([^/]*)", var.instance_template)) > 0 ? flatten(regexall("/projects/([^/]*)", var.instance_template))[0] : null

  # When no network or subnetwork has been defined, we want to use the settings from
  # the template instead.
  network_interface = length(format("%s%s", var.network, var.subnetwork)) == 0 ? [] : [1]
}

###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = local.project_id
  region  = var.region
}

#############
# Instances
#############

resource "google_compute_instance_from_template" "compute_instance" {
  provider            = google
  count               = local.num_instances
  name                = var.add_hostname_suffix ? format("%s%s%s", local.hostname, var.hostname_suffix_separator, format("%03d", count.index + 1)) : local.hostname
  project             = local.project_id
  zone                = var.zone == null ? data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)] : var.zone
  deletion_protection = var.deletion_protection
  resource_policies   = var.resource_policies
  labels              = var.labels

  params {
    resource_manager_tags = var.resource_manager_tags
  }

  dynamic "network_interface" {
    for_each = local.network_interface

    content {
      network            = var.network
      subnetwork         = var.subnetwork
      subnetwork_project = var.subnetwork_project
      network_ip         = length(var.static_ips) == 0 ? "" : element(local.static_ips, count.index)
      dynamic "access_config" {
        for_each = var.access_config
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
        }
      }

      dynamic "ipv6_access_config" {
        for_each = var.ipv6_access_config
        content {
          network_tier = ipv6_access_config.value.network_tier
        }
      }

      dynamic "alias_ip_range" {
        for_each = var.alias_ip_ranges
        content {
          ip_cidr_range         = alias_ip_range.value.ip_cidr_range
          subnetwork_range_name = alias_ip_range.value.subnetwork_range_name
        }
      }
    }
  }

  source_instance_template = var.instance_template
}

