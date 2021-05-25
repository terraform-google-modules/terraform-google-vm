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

terraform {
  required_providers {
    google = {
      version = ">= 3.45.0"
    }
    null = {
      version = ">= 2.1.0"
    }
  }
}

# [START compute_vm_with_multiple_interface]
resource "google_compute_instance" "default" {
  project      = var.project_id # Replace with your project ID in quotes
  zone         = "us-central1-b"
  name         = "backend-instance"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = var.subnet_1 # Replace with self link to a subnetwork in quotes
    network_ip = "10.0.0.14"
  }
  network_interface {
    subnetwork = var.subnet_2 # Replace with self link to a subnetwork in quotes
    network_ip = "10.10.20.14"
  }
}
# [END compute_vm_with_multiple_interface]
