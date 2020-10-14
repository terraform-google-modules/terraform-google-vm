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

module "mig_scale_down" {
  source              = "../../../../examples/mig/scale_down"
  project_id          = var.project_id
  subnetwork          = google_compute_subnetwork.main.name
  service_account     = var.service_account
  autoscaling_enabled = "true"
  min_replicas        = 4

  autoscaling_scale_down = [
    {
      max_replicas_fixed = 1
      max_replicas_percent = 0
      time_window_sec = 300
    }
  ]

  autoscaling_cpu = [
    {
      target = 0.6
    },
  ]
}

