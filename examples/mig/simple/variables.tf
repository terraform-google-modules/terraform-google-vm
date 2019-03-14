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

variable "credentials_path" {
  description = "The path to the GCP credentials JSON file"
}

variable "project_id" {
  description = "The GCP project to use for integration tests"
}

variable "region" {
  description = "The GCP region to create and test resources in"
}

variable "subnetwork" {
  description = "The subnetwork to host the compute instances in"
}

variable "target_size" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
}

variable "service_account" {
  type        = "map"
  description = "Service account email address and scopes"
}
