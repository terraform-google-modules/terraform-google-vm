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

variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "GCP region"
  default     = "us-west1"
}

variable "subnetwork" {
  description = "Subnet to deploy to"
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "machine_type" {
  description = "Machine Type"
  default     = "n1-standard-4"
}

variable "img_src_project" {
  description = "Project holding images"
  default     = ""
}

variable "image_name" {
  description = "Disk image name"
  default     = ""
}

variable "image_family" {
  description = "Disk image family"
  default     = ""
}

variable "root_volume_size_gb" {
  description = "Root volume size in GB"
  default     = "40"
}

variable "tags" {
  description = "Network tags to apply to all instances"
  default     = []
}

variable "labels" {
  description = "Labels to apply to all instances"
  type        = "map"
  default     = {}
}

variable "instance_ips" {
  type        = "list"
  description = "List of static IPs for VM instances"
  default     = []
}

variable "num_instances" {
  description = "Number of instances to create"
  default     = "1"
}

variable "service_account_email" {
  description = "Service account email"
  default     = ""
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = "list"
  default     = []
}

#TODO: This needs work - does not work when you actually try to specify a value
variable "named_port" {
  description = "Named name and named port"
  type        = "list"
  default     = []
}

variable "metadata" {
  type        = "map"
  description = "Metadata for each instance, provided as a map"
  default     = {}
}
