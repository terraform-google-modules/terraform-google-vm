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
  per_module_roles = {
    compute_disk_snapshot = [
      "roles/compute.storageAdmin",
      "roles/logging.logWriter",
    ]

    compute_instance = [
      "roles/compute.admin",
      "roles/compute.networkAdmin",
      "roles/iam.serviceAccountUser",
      "roles/iam.serviceAccountAdmin",
      "roles/compute.instanceAdmin",
      "roles/resourcemanager.projectIamAdmin",
    ]

    instance_template = [
      "roles/compute.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountUser",
      "roles/logging.logWriter",
    ]

    mig = [
      "roles/compute.admin",
      "roles/iam.serviceAccountUser",
      "roles/logging.logWriter",
    ]

    mig_with_percent = [
      "roles/compute.instanceAdmin.v1",
      "roles/compute.viewer",
      "roles/iam.serviceAccountUser",
      "roles/logging.logWriter",
    ]

    umig = [
      "roles/compute.instanceAdmin.v1",
      "roles/iam.serviceAccountUser",
      "roles/logging.logWriter",
    ]

    preemptible_and_regular_instance_templates = [
      "roles/compute.instanceAdmin.v1",
      "roles/iam.serviceAccountUser",
      "roles/logging.logWriter",
    ]

    root = [
      "roles/compute.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountUser",
      "roles/compute.securityAdmin",
      "roles/compute.imageUser",
      "roles/compute.networkAdmin",
      "roles/logging.logWriter",
      "roles/monitoring.viewer",
    ]
  }

  vm_required_roles = concat([
    "roles/compute.admin",
    "roles/compute.networkAdmin",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountAdmin",
    "roles/compute.instanceAdmin",
    "roles/resourcemanager.projectIamAdmin",
  ], flatten(values(local.per_module_roles)))
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

resource "google_organization_iam_member" "ci_vm_account_organization" {
  org_id = var.org_id
  role   = "roles/orgpolicy.policyAdmin"
  member = "serviceAccount:${google_service_account.ci_vm_account.email}"
}

resource "google_service_account_key" "ci_vm_account" {
  service_account_id = google_service_account.ci_vm_account.id
}
