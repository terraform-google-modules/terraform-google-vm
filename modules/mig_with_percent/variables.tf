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

variable "hostname" {
  description = "Hostname prefix for instances"
  default     = "default"
}

variable "region" {
  description = "The GCP region where the managed instance group resides."
}

variable "instance_template_version0" {
  description = "Instance template self_link used to create compute instances for initial version"
}

variable "instance_template_version1" {
  description = "Instance template self_link used to create compute instances for second version"
}

variable "version1_percent" {
  description = "Percentage of instances defined in the second version"
}

variable "target_size" {
  description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "target_pools" {
  description = "The target load balancing pools to assign this group to."
  type        = "list"
  default     = []
}

variable "distribution_policy_zones" {
  description = "The distribution policy, i.e. which zone(s) should instances be create in. Default is all zones in given region."
  type        = "list"
  default     = []
}

#################
# Rolling Update
#################

variable "update_policy" {
  description = "The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html#rolling_update_policy"
  type        = "list"
  default     = []
}

##############
# Healthcheck
##############

variable "http_healthcheck_enable" {
  description = "Enable HTTP healthcheck"
  default     = "false"
}

variable "tcp_healthcheck_enable" {
  description = "Enable TCP healthcheck"
  default     = "false"
}

variable "hc_initial_delay_sec" {
  description = "Health check, intial delay in seconds."
  default     = 30
}

variable "hc_interval_sec" {
  description = "Health check interval in seconds."
  default     = 30
}

variable "hc_timeout_sec" {
  description = "Health check timeout in seconds."
  default     = 10
}

variable "hc_healthy_threshold" {
  description = "Health check healthy threshold."
  default     = 1
}

variable "hc_unhealthy_threshold" {
  description = "Health check unhealthy threshold."
  default     = 5
}

variable "hc_path" {
  description = "Health check http path to check."
  default     = "/"
}

variable "hc_port" {
  description = "Health check port."
  default     = ""
}

#############
# Autoscaler
#############
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
  type        = "list"
  default     = []
}

variable "autoscaling_metric" {
  description = "Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric"
  type        = "list"
  default     = []
}

variable "autoscaling_lb" {
  description = "Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization"
  type        = "list"
  default     = []
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
  type        = "list"
  default     = []
}
