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

  # When no network or subnetwork has been defined, we want to use the settings from
  # the template instead.
  network_interface = length(format("%s%s", var.network, var.subnetwork)) == 0 ? [] : [1]
}

###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

#############
# Instances
#############

resource "google_compute_instance_from_template" "compute_instance" {
  provider            = google
  count               = var.instance_template != null ? local.num_instances : 0
  name                = var.add_hostname_suffix ? format("%s%s%s", local.hostname, var.hostname_suffix_separator, format("%03d", count.index + 1)) : local.hostname
  project             = var.project_id
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

resource "google_compute_instance" "compute_instance" {
  provider            = google
  count               = var.instance_template == null ? local.num_instances : 0
  name                = var.add_hostname_suffix ? format("%s%s%s", local.hostname, var.hostname_suffix_separator, format("%03d", count.index + 1)) : local.hostname
  project             = var.project_id
  zone                = var.zone == null ? data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)] : var.zone
  machine_type        = var.machine_type
  deletion_protection = var.deletion_protection
  resource_policies   = var.resource_policies
  labels              = var.labels
  metadata            = var.metadata
  tags                = var.tags

  dynamic "params" {
    for_each = var.resource_manager_tags != null ? [1] : []
    content {
      resource_manager_tags = var.resource_manager_tags
    }
  }

  lifecycle {
    ignore_changes = [
      key_revocation_action_type,
      effective_labels,
      terraform_labels,
      attached_disk,
      metadata["ssh-keys"],
      metadata["startup-script"],
      scratch_disk,
      scheduling[0].local_ssd_recovery_timeout,
    ]
  }

  boot_disk {
    auto_delete = try(var.boot_disk.auto_delete, true)
    device_name = try(var.boot_disk.device_name, null)

    initialize_params {
      image  = try(var.boot_disk.source_image, null)
      size   = try(var.boot_disk.disk_size_gb, null)
      type   = try(var.boot_disk.disk_type, null)
      labels = try(var.boot_disk.disk_labels, {})
    }

    # Note: disk_encryption_key block is not supported in google provider >= 6.x.
    # KMS encryption is set via initialize_params.provisioned_iops or at resource
    # creation time. kms_key_self_link is retained in the variable for future use.
  }

  dynamic "network_interface" {
    for_each = local.network_interface

    content {
      network            = var.network
      subnetwork         = var.subnetwork
      subnetwork_project = var.subnetwork_project
      nic_type           = var.nic_type
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

  dynamic "service_account" {
    for_each = var.service_account != null ? [var.service_account] : []
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = service_account.value.scopes
    }
  }

  dynamic "scheduling" {
    for_each = var.scheduling != null ? [var.scheduling] : []
    content {
      on_host_maintenance = lookup(scheduling.value, "on_host_maintenance", "MIGRATE")
      automatic_restart   = lookup(scheduling.value, "automatic_restart", true)
      preemptible         = lookup(scheduling.value, "preemptible", false)
    }
  }
}

