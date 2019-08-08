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

output "regular_self_link" {
  description = "Self-link to the regular instance template"
  value       = module.preemptible_and_regular_instance_templates.regular_self_link
}

output "regular_name" {
  description = "Name of the regular instance templates"
  value       = module.preemptible_and_regular_instance_templates.regular_name
}

output "preemptible_self_link" {
  description = "Self-link to the preemptible instance template"
  value       = module.preemptible_and_regular_instance_templates.preemptible_self_link
}

output "preemptible_name" {
  description = "Name of the preemptible instance templates"
  value       = module.preemptible_and_regular_instance_templates.preemptible_name
}
