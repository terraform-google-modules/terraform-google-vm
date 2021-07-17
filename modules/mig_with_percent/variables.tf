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

// This file was automatically generated from a template in ./autogen

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "hostname" {
  description = "Hostname prefix for instances"
  default     = "default"
}

variable "mig_name" {
  type        = string
  description = "Managed instance group name. When variable is empty, name will be derived from var.hostname."
  default     = ""
}

variable "region" {
  description = "The GCP region where the managed instance group resides."
}

variable "instance_template_initial_version" {
  description = "Instance template self_link used to create compute instances for the initial version"
}

variable "instance_template_next_version" {
  description = "Instance template self_link used to create compute instances for the second version"
}

variable "next_version_percent" {
  description = "Percentage of instances defined in the second version"
}

variable "target_size" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "target_pools" {
  description = "The target load balancing pools to assign this group to."
  type        = list(string)
  default     = []
}

variable "distribution_policy_zones" {
  description = "The distribution policy, i.e. which zone(s) should instances be create in. Default is all zones in given region."
  type        = list(string)
  default     = []
}

#################
# Stateful disks
#################
variable "stateful_disks" {
  description = "Disks created on the instances that will be preserved on instance delete. https://cloud.google.com/compute/docs/instance-groups/configuring-stateful-disks-in-migs"
  type = list(object({
    device_name = string
    delete_rule = string
  }))
  default = []
}

#################
# Rolling Update
#################

variable "update_policy" {
  description = "The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html#rolling_update_policy"
  type = list(object({
    max_surge_fixed              = number
    instance_redistribution_type = string
    max_surge_percent            = number
    max_unavailable_fixed        = number
    max_unavailable_percent      = number
    min_ready_sec                = number
    replacement_method           = string
    minimal_action               = string
    type                         = string
  }))
  default = []
}

##############
# Healthcheck
##############

variable "health_check_name" {
  type        = string
  description = "Health check name. When variable is empty, name will be derived from var.hostname."
  default     = ""
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
  })
  default = {
    type                = ""
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
  }
}

#############
# Autoscaler
#############
variable "autoscaler_name" {
  type        = string
  description = "Autoscaler name. When variable is empty, name will be derived from var.hostname."
  default     = ""
}

variable "autoscaling_enabled" {
  description = "Creates an autoscaler for the managed instance group"
  default     = "false"
}

variable "max_replicas" {
  description = "The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas."
  default     = 10
}

variable "min_replicas" {
  description = "The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0."
  default     = 2
}

variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
  default     = 60
}

variable "autoscaling_cpu" {
  description = "Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization"
  type        = list(map(number))
  default     = []
}

variable "autoscaling_metric" {
  description = "Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric"
  type = list(object({
    name   = string
    target = number
    type   = string
  }))
  default = []
}

variable "autoscaling_lb" {
  description = "Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization"
  type        = list(map(number))
  default     = []
}

variable "autoscaling_scale_in_control" {
  description = "Autoscaling, scale-in control block. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#scale_in_control"
  type = object({
    fixed_replicas   = number
    percent_replicas = number
    time_window_sec  = number
  })
  default = {
    fixed_replicas   = null
    percent_replicas = null
    time_window_sec  = null
  }
}

##########################

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "named_ports" {
  description = "Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports"
  type = list(object({
    name = string
    port = number
  }))
  default = []
}

variable "wait_for_instances" {
  description = "Whether to wait for all instances to be created/updated before returning. Note that if this is set to true and the operation does not succeed, Terraform will continue trying until it times out."
  default     = "false"
}

variable "mig_timeouts" {
  description = "Times for creation, deleting and updating the MIG resources. Can be helpful when using wait_for_instances to allow a longer VM startup time. "
  type = object({
    create = string
    update = string
    delete = string
  })
  default = {
    create = "5m"
    update = "5m"
    delete = "15m"
  }
}
