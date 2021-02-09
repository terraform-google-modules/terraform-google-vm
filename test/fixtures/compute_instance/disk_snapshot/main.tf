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


module "disk_snapshot" {
  source          = "../../../../examples/compute_instance/disk_snapshot"
  project_id      = var.project_id
  region          = "us-central1"
  subnetwork      = google_compute_subnetwork.main.self_link
  num_instances   = 1
  service_account = var.service_account
}
