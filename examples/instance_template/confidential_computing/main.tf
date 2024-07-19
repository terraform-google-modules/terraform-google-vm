/**
 * Copyright 2024 Google LLC
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

module "instance_template" {
  source = "../../../modules/instance_template"

  region          = var.region
  project_id      = var.project_id
  service_account = var.service_account
  subnetwork      = var.subnetwork

  name_prefix                = "confidential-template"
  source_image_project       = "ubuntu-os-cloud"
  source_image               = "ubuntu-2004-lts"
  machine_type               = "n2d-standard-2"
  min_cpu_platform           = "AMD Milan"
  enable_confidential_vm     = true
  confidential_instance_type = "SEV_SNP"
}
