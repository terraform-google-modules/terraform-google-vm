/**
 * Copyright 2021 Google LLC
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

provider "google" {

  project = var.project_id
  region  = var.region
  version = "~> 3.0"
}

resource "google_compute_address" "ip_address" {
  name = "external-ip-alias-ip-range"
}

module "instance_template" {
  source          = "../../../modules/instance_template"
  project_id      = var.project_id
  subnetwork      = var.subnetwork
  service_account = var.service_account
  name_prefix     = "alias-ip-range"

  alias_ip_range = {
    ip_cidr_range         = "/24"
    subnetwork_range_name = var.subnetwork
  }
}
