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

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "region" {
  description = "The GCP region where the unmanaged instance group resides."
  type        = string
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "additional_networks" {
  description = "Additional network interface details for GCE, if any."
  default     = []
  type = list(object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
    network_ip         = string
    access_config = list(object({
      nat_ip       = string
      network_tier = string
    }))
  }))
}

variable "hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "static_ips" {
  type        = list(string)
  description = "List of static IPs for VM instances"
  default     = []
}

variable "num_instances" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  default     = "1"
}

variable "named_ports" {
  description = "Named name and named port"
  type = list(object({
    name = string
    port = number
  }))
  default = []
}

variable "instance_template" {
  description = "Instance template self_link used to create compute instances"
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(list(object({
    nat_ip       = string
    network_tier = string
  })))
  default = []
}
