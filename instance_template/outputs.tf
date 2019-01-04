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

output "self_link" {
  value = "${element(coalescelist(google_compute_instance_template.tpl_0.*.self_link, google_compute_instance_template.tpl_1.*.self_link, google_compute_instance_template.tpl_2.*.self_link, google_compute_instance_template.tpl_3.*.self_link, google_compute_instance_template.tpl_4.*.self_link, google_compute_instance_template.tpl_5.*.self_link), 0)}"
}

output "name" {
  value = "${element(coalescelist(google_compute_instance_template.tpl_0.*.name, google_compute_instance_template.tpl_1.*.name, google_compute_instance_template.tpl_2.*.name, google_compute_instance_template.tpl_3.*.name, google_compute_instance_template.tpl_4.*.name, google_compute_instance_template.tpl_5.*.name), 0)}"
}
