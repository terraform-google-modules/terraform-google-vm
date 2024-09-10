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

module "confidential-computing-org-policy" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.1"

  project_id       = var.project_id
  policy_for       = "project"
  constraint       = "constraints/compute.restrictNonConfidentialComputing"
  policy_type      = "list"
  deny             = ["compute.googleapis.com"]
  deny_list_length = 1
}

module "enforce-cmek-org-policy" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.3"

  project_id       = var.project_id
  policy_for       = "project"
  constraint       = "constraints/gcp.restrictNonCmekServices"
  policy_type      = "list"
  deny             = ["compute.googleapis.com"]
  deny_list_length = 1
}
