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

# Example: MIG with instance_lifecycle_policy set to DO_NOTHING.
#
# This configuration prevents the MIG from automatically repairing or
# recreating instances that have been stopped externally. By default
# ("REPAIR"), the MIG recreates failed or unhealthy instances automatically.

provider "google" {
  region = var.region
}

provider "google-beta" {
  region = var.region
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 15.0"

  project_id         = var.project_id
  region             = var.region
  subnetwork         = var.subnetwork
  service_account    = var.service_account
  subnetwork_project = var.project_id
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 15.0"

  project_id        = var.project_id
  region            = var.region
  target_size       = var.target_size
  hostname          = "mig-lifecycle-policy"
  instance_template = module.instance_template.self_link

  # Set to null (or omit entirely) to use GCP default behaviour ("REPAIR").
  instance_lifecycle_policy = {
    default_action_on_failure = "DO_NOTHING"
    on_failed_health_check    = "DO_NOTHING"
    force_update_on_repair    = "NO"
    on_repair = {
      allow_changing_zone = "NO"
    }
  }
}
