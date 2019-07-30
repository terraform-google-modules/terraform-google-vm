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

locals {
  credentials_path = "${path.module}/${var.credentials_path_relative}"
}

module "mig_simple" {
  source           = "../../../../examples/mig/simple"
  credentials_path = local.credentials_path
  project_id       = var.project_id
  region           = var.region
  subnetwork       = google_compute_subnetwork.main.name
  target_size      = 4
  service_account  = var.service_account
}

