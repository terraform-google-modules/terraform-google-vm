/**
 * Copyright 2020 Google LLC
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

variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "names" {
  description = "Instance names."
  type        = list(string)
}

variable "region" {
  type        = string
  description = "Region where the instances should be created."
}

variable "mig_name" {
  type        = string
  description = "Managed instance group name to attach instances to."
}

variable "stateful_disks" {
  description = "Map of maps of stateful disks."
  type        = any
  default     = {}
}

variable "stateful_metadata" {
  description = "Map of maps of stateful metadata."
  type        = any
  default     = {}
}

variable "minimal_action" {
  type        = string
  description = "The minimal action to perform on the instance during an update."
  default     = "NONE"
}

variable "most_disruptive_allowed_action" {
  type        = string
  description = "The most disruptive action to perform on the instance during an update."
  default     = "REPLACE"
}
