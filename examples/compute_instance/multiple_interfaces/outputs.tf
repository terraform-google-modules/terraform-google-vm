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


output "project_id" {
  value       = google_compute_instance.default.project
  description = "Google Cloud project ID"
}

output "instance_self_link" {
  value       = google_compute_instance.default.self_link
  description = "The URI of the instance rule  being created"
}

output "network_name_1" {
  value       = google_compute_instance.default.network_interface[0].network
  description = "The name of the VPC network where the VM's first network interface is created"
}

output "network_name_2" {
  value       = google_compute_instance.default.network_interface[1].network
  description = "The name of the VPC network where the VM's second network interface is created"
}
