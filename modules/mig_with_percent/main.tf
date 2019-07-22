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

locals {
  distribution_policy_zones = {
    default = ["${data.google_compute_zones.available.names}"]
    user    = ["${var.distribution_policy_zones}"]
  }
}

data "google_compute_zones" "available" {}

resource "google_compute_region_instance_group_manager" "mig_with_percent" {
  provider           = "google-beta"
  base_instance_name = "${var.hostname}"

  version = {
    name              = "${var.hostname}-mig-version-0"
    instance_template = "${var.instance_template_version0}"
  }

  version = {
    name              = "${var.hostname}-mig-version-1"
    instance_template = "${var.instance_template_version1}"

    target_size {
      percent = "${var.version1_percent}"
    }
  }

  name         = "${var.hostname}-mig-with-percent"
  region       = "${var.region}"
  named_port   = ["${var.named_ports}"]
  target_pools = ["${var.target_pools}"]
  target_size  = "${var.autoscaling_enabled ? var.min_replicas : var.target_size}"

  auto_healing_policies {
    health_check      = "${var.http_healthcheck_enable || var.tcp_healthcheck_enable ? element(concat(google_compute_health_check.http_healthcheck.*.self_link, google_compute_health_check.tcp_healthcheck.*.self_link, list("")),0) : ""}"
    initial_delay_sec = "${var.hc_initial_delay_sec}"
  }

  distribution_policy_zones = ["${local.distribution_policy_zones["${length(var.distribution_policy_zones) == 0 ? "default" : "user"}"]}"]
  update_policy             = ["${var.update_policy}"]

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "google_compute_region_autoscaler" "autoscaler" {
  provider = "google"
  count    = "${var.autoscaling_enabled ? 1 : 0}"
  name     = "${var.hostname}-autoscaler"
  target   = "${google_compute_region_instance_group_manager.mig_with_percent.self_link}"

  autoscaling_policy = {
    max_replicas               = "${var.max_replicas}"
    min_replicas               = "${var.min_replicas}"
    cooldown_period            = "${var.cooldown_period}"
    cpu_utilization            = ["${var.autoscaling_cpu}"]
    metric                     = ["${var.autoscaling_metric}"]
    load_balancing_utilization = ["${var.autoscaling_lb}"]
  }

  depends_on = ["google_compute_region_instance_group_manager.mig_with_percent"]
}

resource "google_compute_health_check" "http_healthcheck" {
  provider = "google"
  count    = "${var.http_healthcheck_enable ? 1 : 0}"
  name     = "${var.hostname}-http-healthcheck"

  check_interval_sec  = "${var.hc_interval_sec}"
  timeout_sec         = "${var.hc_timeout_sec}"
  healthy_threshold   = "${var.hc_healthy_threshold}"
  unhealthy_threshold = "${var.hc_unhealthy_threshold}"

  http_health_check {
    request_path = "${var.hc_path}"
    port         = "${var.hc_port}"
  }
}

resource "google_compute_health_check" "tcp_healthcheck" {
  provider = "google"
  count    = "${var.tcp_healthcheck_enable ? 1 : 0}"
  name     = "${var.hostname}-tcp-healthcheck"

  check_interval_sec  = "${var.hc_interval_sec}"
  timeout_sec         = "${var.hc_timeout_sec}"
  healthy_threshold   = "${var.hc_healthy_threshold}"
  unhealthy_threshold = "${var.hc_unhealthy_threshold}"

  tcp_health_check {
    port = "${var.hc_port}"
  }
}
