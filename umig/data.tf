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

###############
# Data Sources
###############

data "google_compute_zones" "available" {}

data "google_compute_image" "image" {
  project = "${var.image_name != "" ? var.img_src_project : "centos-cloud"}"
  name    = "${var.image_name != "" ? var.image_name : "centos-6-v20180716"}"
}

data "google_compute_image" "image_family" {
  project = "${var.image_family != "" ? var.img_src_project : "centos-cloud"}"
  family  = "${var.image_family != "" ? var.image_family : "centos-6"}"
}
