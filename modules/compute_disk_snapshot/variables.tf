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

variable "name" {
  description = "Name of the resource policy to create"
  type        = string
}

variable "project" {
  description = "The project ID where the resources will be created"
  type        = string
}

variable "region" {
  description = "Region where resource policy resides"
  type        = string
}

variable "snapshot_schedule_policy" {
  description = "Snapshot policy details. All the values are required, but the optional ones can be set to `null`. Check Terraform documentation to find out which values are optional https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy#snapshot_schedule_policy"
  type = list(object(
    {
      retention_policy = list(object(
        {
          max_retention_days    = number
          on_source_disk_delete = string
        }
      ))
      schedule = list(object(
        {
          daily_schedule = list(object(
            {
              days_in_cycle = number
              start_time    = string
            }
          ))
          hourly_schedule = list(object(
            {
              hours_in_cycle = number
              start_time     = string
            }
          ))
          weekly_schedule = list(object(
            {
              day_of_weeks = set(object(
                {
                  day        = string
                  start_time = string
                }
              ))
            }
          ))
        }
      ))
      snapshot_properties = list(object(
        {
          guest_flush       = bool
          labels            = map(string)
          storage_locations = list(string)
        }
      ))
    }
  ))
  default = []
}

variable "disks" {
  description = "List of self_links persistent disks to attach the snapshot policy to (ie. projects/project_id/disks/diskname/zones/zone_name)"
  default     = []
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on"
  type        = list(any)
  default     = []
}
