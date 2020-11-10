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

// This file was automatically generated from a template in ./autogen

output "self_link" {
  description = "Self-link of managed instance group"
  value       = google_compute_region_instance_group_manager.mig_with_percent.self_link
}

output "instance_group" {
  description = "Instance-group url of managed instance group"
  value       = google_compute_region_instance_group_manager.mig_with_percent.instance_group
}

output "instance_group_manager" {
  description = "An instance of google_compute_region_instance_group_manager of the instance group."
  value       = google_compute_region_instance_group_manager.mig_with_percent
}

output "health_check_self_links" {
  description = "All self_links of healthchecks created for the instance group."
  value       = local.healthchecks
}
