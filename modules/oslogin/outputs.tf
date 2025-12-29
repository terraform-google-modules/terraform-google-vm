/**
 * Copyright 2024 Google LLC
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

output "fingerprint" {
  description = "The SHA-256 fingerprint of the SSH public key"
  value       = google_os_login_ssh_public_key.ssh_key.fingerprint
}

output "name" {
  description = "The canonical resource name"
  value       = google_os_login_ssh_public_key.ssh_key.name
}

output "expiration_time_usec" {
  description = "The expiration time in microseconds since epoch"
  value       = google_os_login_ssh_public_key.ssh_key.expiration_time_usec
}
