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

output "instances_self_links" {
  description = "List of self-links for compute instances"
  value       = google_compute_instance_from_template.compute_instance.*.self_link
}

output "names" {
  description = "List of compute instance names"
  value       = google_compute_instance_from_template.compute_instance.*.name
}

output "ip_list_by_instance" {
  description = "List of IP addresses for each instance by name"
  value       = { for instance in google_compute_instance_from_template.compute_instance: instance["name"] => [ for nic in instance["network_interface"]: nic["network_ip"] ] }
}

output "available_zones" {
  description = "List of available zones in region"
  value       = data.google_compute_zones.available.names
}
