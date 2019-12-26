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

module "umig_named_ports" {
  source          = "../../../../examples/umig/named_ports"
  project_id      = var.project_id
  region          = "us-central1"
  subnetwork      = google_compute_subnetwork.main.name
  num_instances   = 4
  service_account = var.service_account

  named_ports = [
    {
      name = "https"
      port = "443"
    },
    {
      name = "http"
      port = "80"
    },
  ]
}

