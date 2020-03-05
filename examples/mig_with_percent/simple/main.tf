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

provider "google" {

  project = var.project_id
  region  = var.region
  version = "~> 3.0"
}

provider "google-beta" {

  project = var.project_id
  region  = var.region
  version = "~> 3.0"
}

module "preemptible_and_regular_instance_templates" {
  source          = "../../../modules/preemptible_and_regular_instance_templates"
  subnetwork      = var.subnetwork
  service_account = var.service_account
}

module "mig_with_percent" {
  source                            = "../../../modules/mig_with_percent"
  region                            = var.region
  target_size                       = 4
  hostname                          = "mig-with-percent-simple"
  instance_template_initial_version = module.preemptible_and_regular_instance_templates.regular_self_link
  instance_template_next_version    = module.preemptible_and_regular_instance_templates.preemptible_self_link
  next_version_percent              = 50
}
