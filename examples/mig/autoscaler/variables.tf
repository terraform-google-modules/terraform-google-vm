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
  description = "The GCP project to use for integration tests"
  type        = string
}

variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "us-central1"
}

variable "subnetwork" {
  description = "The subnetwork to host the compute instances in"
}

variable "service_account" {
  default = null
  type = object({
    email  = string
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account."
}

variable "autoscaling_enabled" {
  description = "Creates an autoscaler for the managed instance group"
}

variable "min_replicas" {
  description = "The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0."
}



variable "autoscaling_cpu" {
  description = "Autoscaling, cpu utilization policy block as single element array. https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_autoscaler#cpu_utilization"
  type = list(object({
    target            = number
    predictive_method = string
  }))
}

