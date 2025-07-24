/**
 * Copyright 2025 Google LLC
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

module "confidential_gpu" {
  source                = "../../../examples/confidential_gpu"
  project_id            = var.project_id
  region                = "us-east5"
  subnetwork            = google_compute_subnetwork.main.self_link
  keyring               = "key-ring-test"
  key                   = "key-test"
  service_account_roles = ["roles/compute.imageUser", "roles/compute.networkUser"]
}
