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
  vm_required_roles = [
    "roles/owner",
    "roles/compute.admin",
    "roles/compute.networkAdmin",
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin",
  ]
}

resource "google_service_account" "ci_vm_account" {
  project      = module.project_ci_vm.project_id
  account_id   = "ci-vm-account"
  display_name = "ci-vm-account"
}

resource "google_project_iam_member" "ci_vm_account" {
  count = length(local.vm_required_roles)

  project = module.project_ci_vm.project_id
  role    = local.vm_required_roles[count.index]
  member  = "serviceAccount:${google_service_account.ci_vm_account.email}"
}

resource "google_service_account_key" "ci_vm_account" {
  service_account_id = google_service_account.ci_vm_account.id
}
