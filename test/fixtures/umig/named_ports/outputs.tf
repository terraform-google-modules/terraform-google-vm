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

output "self_links" {
  value = "${module.umig_named_ports.self_links}"
}

output "instances_self_links" {
  value = "${module.umig_named_ports.instances_self_links}"
}

output "project_id" {
  value = "${var.project_id}"
}

output "region" {
  value = "${var.region}"
}

output "credentials_path" {
  value = "${local.credentials_path}"
}

output "available_zones" {
  value = "${module.umig_named_ports.available_zones}"
}

output "num_instances" {
  value = "${var.num_instances}"
}
