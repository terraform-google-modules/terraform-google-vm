/**
 * Copyright 2019 Google LLC
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
  per_module_services = {
    compute_disk_snapshot = [
      "compute.googleapis.com",
    ]

    compute_instance = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    instance_template = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    mig = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    mig_with_percent = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    umig = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    preemptible_and_regular_instance_templates = [
      "compute.googleapis.com",
      "iam.googleapis.com",
    ]

    root = [
      "compute.googleapis.com",
      "iam.googleapis.com",
      "logging.googleapis.com",
      "monitoring.googleapis.com",
      "serviceusage.googleapis.com",
    ]
  }
}

module "project_ci_vm" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 17.0"

  name              = "ci-vm-module"
  random_project_id = true
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = concat([
    "cloudresourcemanager.googleapis.com",
    "storage-api.googleapis.com",
  ], flatten(values(local.per_module_services)))
}
