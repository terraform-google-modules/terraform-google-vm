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

variable "project_id" {
  description = "The ID of the project in which the compute instance will be created."
  type        = string
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  type        = string
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  type        = string
  default     = ""
}

variable "hostname" {
  description = "Hostname of instances"
  type        = string
  default     = ""
}

variable "add_hostname_suffix" {
  description = "Adds a suffix to the hostname"
  type        = bool
  default     = true
}

variable "static_ips" {
  type        = list(string)
  description = "List of static IPs for VM instances"
  default     = []
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "ipv6_access_config" {
  description = "IPv6 access configurations. Currently a max of 1 IPv6 access configuration is supported. If not specified, the instance will have no external IPv6 Internet access."
  type = list(object({
    network_tier = string
  }))
  default = []
}

variable "num_instances" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  type        = number
  default     = 1
}

variable "instance_template" {
  description = "Instance template self_link used to create compute instances. When null, a standalone google_compute_instance is created and machine_type + boot_disk must be provided."
  type        = string
  default     = null
}

variable "machine_type" {
  description = "(Optional) The machine type to use for standalone instances (when instance_template is null). Example: n2-standard-4."
  type        = string
  default     = null
}

variable "boot_disk" {
  description = "(Optional) Boot disk configuration for standalone instances (when instance_template is null)."
  type = object({
    auto_delete       = optional(bool, true)
    device_name       = optional(string)
    source_image      = optional(string)
    disk_size_gb      = optional(number)
    disk_type         = optional(string)
    disk_labels       = optional(map(string), {})
    kms_key_self_link = optional(string)
  })
  default = null
}

variable "service_account" {
  description = "(Optional) Service account to attach to standalone instances (when instance_template is null)."
  type = object({
    email  = optional(string)
    scopes = list(string)
  })
  default = null
}

variable "metadata" {
  description = "(Optional) Metadata key/value pairs to make available from within standalone instances."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "(Optional) Network tags to attach to standalone instances."
  type        = list(string)
  default     = []
}

variable "scheduling" {
  description = "(Optional) Scheduling configuration for standalone instances."
  type = object({
    on_host_maintenance = optional(string, "MIGRATE")
    automatic_restart   = optional(bool, true)
    preemptible         = optional(bool, false)
  })
  default = null
}

variable "region" {
  type        = string
  description = "Region where the instances should be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}

variable "hostname_suffix_separator" {
  type        = string
  description = "Separator character to compose hostname when add_hostname_suffix is set to true."
  default     = "-"
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  default     = false
}

variable "alias_ip_ranges" {
  description = "(Optional) An array of alias IP ranges for this network interface. Can only be specified for network interfaces on subnet-mode networks."
  type = list(object({
    ip_cidr_range         = string
    subnetwork_range_name = string
  }))
  default = []
}

variable "resource_policies" {
  description = "(Optional) A list of short names or self_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported."
  type        = list(string)
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "(Optional) Labels to override those from the template, provided as a map"
  default     = null
}

variable "resource_manager_tags" {
  description = "(Optional) A tag is a key-value pair that can be attached to a Google Cloud resource. You can use tags to conditionally allow or deny policies based on whether a resource has a specific tag. This value is not returned by the API. In Terraform, this value cannot be updated and changing it will recreate the resource."
  type        = map(string)
  default     = null
}

variable "nic_type" {
  description = "(Optional) The type of vNIC to be used on the primary network interface. Possible values: GVNIC, VIRTIO_NET. Changing this forces recreation."
  type        = string
  default     = null
}
