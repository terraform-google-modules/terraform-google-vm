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

variable "name_prefix" {
  description = "Name prefix for the instance template"
  type        = string
  default     = "default-instance-template"
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  type        = string
  default     = "n1-standard-1"
}

variable "min_cpu_platform" {
  description = "Specifies a minimum CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. See the complete list: https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform"
  type        = string
  default     = null
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

variable "preemptible" {
  type        = bool
  description = "Allow the instance to be preempted"
  default     = false
}

variable "spot" {
  type        = bool
  description = "Provision a SPOT instance"
  default     = false
}

variable "automatic_restart" {
  type        = bool
  description = "(Optional) Specifies whether the instance should be automatically restarted if it is terminated by Compute Engine (not terminated by a user)."
  default     = true
}

variable "maintenance_interval" {
  type        = string
  description = "Specifies the frequency of planned maintenance events"
  default     = null
  validation {
    condition     = var.maintenance_interval == null || var.maintenance_interval == "PERIODIC"
    error_message = "var.maintenance_interval must be set to null or \"PERIODIC\""
  }
}

variable "on_host_maintenance" {
  type        = string
  description = "Instance availability Policy"
  default     = "MIGRATE"
}

variable "spot_instance_termination_action" {
  description = "Action to take when Compute Engine preempts a Spot VM."
  type        = string
  default     = "STOP"

  validation {
    condition     = contains(["STOP", "DELETE"], var.spot_instance_termination_action)
    error_message = "Allowed values for spot_instance_termination_action are: \"STOP\" or \"DELETE\"."
  }
}

variable "region" {
  type        = string
  description = "Region where the instance template should be created."
  default     = null
}

variable "enable_nested_virtualization" {
  type        = bool
  description = "Defines whether the instance should have nested virtualization enabled."
  default     = false
}

variable "threads_per_core" {
  description = "The number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1."
  type        = number
  default     = null
}

variable "resource_policies" {
  type        = list(string)
  description = "A list of self_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported."
  default     = []
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
  default     = "rocky-linux-9-optimized-gcp"
}

variable "source_image_project" {
  description = "Project where the source image comes from. The default project contains Rocky Linux images."
  type        = string
  default     = "rocky-linux-cloud"
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

variable "disk_labels" {
  description = "Labels to be assigned to boot disk, provided as a map"
  type        = map(string)
  default     = {}
}

variable "disk_encryption_key" {
  description = "The id of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance"
  type        = string
  default     = null
}

variable "auto_delete" {
  description = "Whether or not the boot disk should be auto-deleted"
  type        = string
  default     = "true"
}

variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#disk_name"
  type = list(object({
    auto_delete     = optional(bool, true)
    boot            = optional(bool, false)
    device_name     = optional(string)
    disk_name       = optional(string)
    disk_size_gb    = optional(number)
    disk_type       = optional(string)
    disk_labels     = optional(map(string), {})
    interface       = optional(string)
    mode            = optional(string)
    source          = optional(string)
    source_image    = optional(string)
    source_snapshot = optional(string)
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

variable "network_ip" {
  description = "Private IP address to assign to the instance if desired."
  type        = string
  default     = ""
}

variable "nic_type" {
  description = "Valid values are \"VIRTIO_NET\", \"GVNIC\" or set to null to accept API default behavior."
  type        = string
  default     = null

  validation {
    condition     = var.nic_type == null || var.nic_type == "GVNIC" || var.nic_type == "VIRTIO_NET"
    error_message = "The \"nic_type\" variable must be set to \"VIRTIO_NET\", \"GVNIC\", or null to allow API default selection."
  }
}

variable "stack_type" {
  description = "The stack type for this network interface to identify whether the IPv6 feature is enabled or not. Values are `IPV4_IPV6` or `IPV4_ONLY`. Default behavior is equivalent to IPV4_ONLY."
  type        = string
  default     = null
}

variable "additional_networks" {
  description = "Additional network interface details for GCE, if any."
  default     = []
  type = list(object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
    network_ip         = string
    nic_type           = string
    stack_type         = string
    queue_count        = number
    access_config = list(object({
      nat_ip       = string
      network_tier = string
    }))
    ipv6_access_config = list(object({
      network_tier = string
    }))
    alias_ip_range = list(object({
      ip_cidr_range         = string
      subnetwork_range_name = string
    }))
  }))
  validation {
    condition = alltrue([
      for ni in var.additional_networks : ni.nic_type == "GVNIC" || ni.nic_type == "VIRTIO_NET" || ni.nic_type == null
    ])
    error_message = "In the variable additional_networks, field \"nic_type\" must be either \"GVNIC\", \"VIRTIO_NET\" or null."
  }
  validation {
    condition = alltrue([
      for ni in var.additional_networks : ni.stack_type == "IPV4_ONLY" || ni.stack_type == "IPV4_IPV6" || ni.stack_type == null
    ])
    error_message = "In the variable additional_networks, field \"stack_type\" must be either \"IPV4_ONLY\", \"IPV4_IPV6\" or null."
  }
}

variable "total_egress_bandwidth_tier" {
  description = "Egress bandwidth tier setting for supported VM families"
  type        = string
  default     = "DEFAULT"
  validation {
    condition     = contains(["DEFAULT", "TIER_1"], var.total_egress_bandwidth_tier)
    error_message = "Allowed values for bandwidth_tier are 'DEFAULT' or 'TIER_1'."
  }
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
# Shielded VMs
###########################
variable "enable_shielded_vm" {
  type        = bool
  default     = false
  description = "Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images"
}

variable "shielded_instance_config" {
  description = "Not used unless enable_shielded_vm is true. Shielded VM configuration for the instance."
  type = object({
    enable_secure_boot          = bool
    enable_vtpm                 = bool
    enable_integrity_monitoring = bool
  })

  default = {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

###########################
# Confidential Compute VMs
###########################
variable "enable_confidential_vm" {
  type        = bool
  default     = false
  description = "Whether to enable the Confidential VM configuration on the instance. Note that the instance image must support Confidential VMs. See https://cloud.google.com/compute/docs/images"
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

###########################
# Guest Accelerator (GPU)
###########################
variable "gpu" {
  description = "GPU information. Type and count of GPU to attach to the instance template. See https://cloud.google.com/compute/docs/gpus more details"
  type = object({
    type  = string
    count = number
  })
  default = null
}

##################
# alias IP range
##################
variable "alias_ip_range" {
  description = <<EOF
An array of alias IP ranges for this network interface. Can only be specified for network interfaces on subnet-mode networks.
ip_cidr_range: The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. At the time of writing only a netmask (e.g. /24) may be supplied, with a CIDR format resulting in an API error.
subnetwork_range_name: The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used.
EOF
  type = object({
    ip_cidr_range         = string
    subnetwork_range_name = string
  })
  default = null
}
