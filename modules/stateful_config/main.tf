/**
 * Copyright 2020 Google LLC
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

#####################
# Per Instance Config
#####################

resource "google_compute_region_per_instance_config" "this" {
  count    = length(var.names)
  provider = google-beta

  project                        = var.project_id
  region                         = var.region
  region_instance_group_manager  = var.mig_name
  minimal_action                 = var.minimal_action
  most_disruptive_allowed_action = var.most_disruptive_allowed_action

  name = element(var.names, count.index)

  preserved_state {
    metadata = lookup(var.stateful_metadata, element(var.names, count.index), {})
    dynamic "disk" {
      for_each = lookup(var.stateful_disks, element(var.names, count.index), {})
      content {
        device_name = lookup(disk.value, "device_name", null)
        source      = lookup(disk.value, "source", null)
      }
    }
  }

  lifecycle {
    ignore_changes = [
      preserved_state
    ]
  }
}
