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
  healthchecks = concat(
    google_compute_health_check.http_healthcheck.*.self_link,
    google_compute_health_check.tcp_healthcheck.*.self_link,
  )
  distribution_policy_zones_base = {
    default = data.google_compute_zones.available.names
    user    = var.distribution_policy_zones
  }
  distribution_policy_zones = local.distribution_policy_zones_base[length(var.distribution_policy_zones) == 0 ? "default" : "user"]
}

data "google_compute_zones" "available" {
}

resource "google_compute_region_instance_group_manager" "mig" {
  provider           = google-beta
  base_instance_name = var.hostname

  version {
    name              = "${var.hostname}-mig-version-0"
    instance_template = var.instance_template
  }

  name   = "${var.hostname}-mig"
  region = var.region
  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = lookup(named_port.value, "name", null)
      port = lookup(named_port.value, "port", null)
    }
  }
  target_pools = var.target_pools
  target_size  = var.autoscaling_enabled ? var.min_replicas : var.target_size

  auto_healing_policies {
    health_check      = length(local.healthchecks) > 0 ? local.healthchecks[0] : ""
    initial_delay_sec = length(local.healthchecks) > 0 ? var.hc_initial_delay_sec : 0
  }
  distribution_policy_zones = local.distribution_policy_zones
  dynamic "update_policy" {
    for_each = var.update_policy
    content {
      max_surge_fixed         = lookup(update_policy.value, "max_surge_fixed", null)
      max_surge_percent       = lookup(update_policy.value, "max_surge_percent", null)
      max_unavailable_fixed   = lookup(update_policy.value, "max_unavailable_fixed", null)
      max_unavailable_percent = lookup(update_policy.value, "max_unavailable_percent", null)
      min_ready_sec           = lookup(update_policy.value, "min_ready_sec", null)
      minimal_action          = update_policy.value.minimal_action
      type                    = update_policy.value.type
    }
  }

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "google_compute_region_autoscaler" "autoscaler" {
  provider = google
  count    = var.autoscaling_enabled ? 1 : 0
  name     = "${var.hostname}-autoscaler"
  target   = google_compute_region_instance_group_manager.mig.self_link

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period
    dynamic "cpu_utilization" {
      for_each = var.autoscaling_cpu
      content {
        target = lookup(cpu_utilization.value, "target", null)
      }
    }
    dynamic "metric" {
      for_each = var.autoscaling_metric
      content {
        name   = lookup(metric.value, "name", null)
        target = lookup(metric.value, "target", null)
        type   = lookup(metric.value, "type", null)
      }
    }
    dynamic "load_balancing_utilization" {
      for_each = var.autoscaling_lb
      content {
        target = lookup(load_balancing_utilization.value, "target", null)
      }
    }
  }
}

resource "google_compute_health_check" "http_healthcheck" {
  provider = google
  count    = var.http_healthcheck_enable ? 1 : 0
  name     = "${var.hostname}-http-healthcheck"

  check_interval_sec  = var.hc_interval_sec
  timeout_sec         = var.hc_timeout_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold

  http_health_check {
    request_path = var.hc_path
    port         = var.hc_port
  }
}

resource "google_compute_health_check" "tcp_healthcheck" {
  provider = google
  count    = var.tcp_healthcheck_enable ? 1 : 0
  name     = "${var.hostname}-tcp-healthcheck"

  check_interval_sec  = var.hc_interval_sec
  timeout_sec         = var.hc_timeout_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold

  tcp_health_check {
    port = var.hc_port
  }
}

