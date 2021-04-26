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

module "mig_healthcheck" {
  source              = "../../../../examples/mig/healthcheck"
  project_id          = var.project_id
  subnetwork          = google_compute_subnetwork.main.name
  service_account     = var.service_account
  autoscaling_enabled = "true"
  min_replicas        = 2
  autoscaler_name     = "mig-as"

  autoscaling_cpu = [
    {
      target = 0.4
    },
  ]

  health_check_name = "mig-https-hc"
  health_check = {
    type                = "https"
    initial_delay_sec   = 120
    check_interval_sec  = 5
    healthy_threshold   = 2
    timeout_sec         = 5
    unhealthy_threshold = 2
    response            = ""
    proxy_header        = "NONE"
    port                = 443
    request             = ""
    request_path        = "/"
    host                = "localhost"
  }
}
