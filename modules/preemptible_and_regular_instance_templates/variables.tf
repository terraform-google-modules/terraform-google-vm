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
}

variable "region" {
  type        = string
  description = "Region where the instance template should be created."
}

variable "name_prefix" {
  description = "Name prefix for the instance template"
  type        = string
  default     = "default-it"
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  type        = string
  default     = "n1-standard-1"
}

variable "can_ip_forward" {
  description = "Enable IP forwarding, for NAT instances for example"
  type        = string
  default     = "false"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

#######
# disk
#######
variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public Rocky Linux 9 optimized for GCP image."
  type        = string
  default     = ""
}

variable "source_image_family" {
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public Rocky Linux 9 optimized for GCP image."
  type        = string
  default     = ""
}

variable "source_image_project" {
  description = "Project where the source image comes from. The default project contains Rocky Linux images."
  type        = string
  default     = ""
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "100"
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "auto_delete" {
  description = "Whether or not the boot disk should be auto-deleted"
  type        = bool
  default     = true
}

variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#disk_name"
  type = list(object({
    disk_name    = string
    device_name  = string
    auto_delete  = bool
    boot         = bool
    disk_size_gb = number
    disk_type    = string
    disk_labels  = map(string)
  }))
  default = []
}

####################
# network_interface
####################
variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  type        = string
  default     = ""
}

variable "subnetwork_project" {
  description = "The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used."
  type        = string
  default     = ""
}

###########
# metadata
###########

variable "startup_script" {
  description = "User startup script to run when instances spin up"
  type        = string
  default     = ""
}

variable "metadata" {
  type        = map(string)
  description = "Metadata, provided as a map"
  default     = {}
}

##################
# service_account
##################

variable "service_account" {
  type = object({
    email  = string
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account."
}

###########################
# Public IP
###########################
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
