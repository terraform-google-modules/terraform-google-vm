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

output "single_key_fingerprint" {
  description = "The fingerprint of the single SSH key"
  value       = module.oslogin_single_key.fingerprint
}

output "multiple_accounts_fingerprints" {
  description = "The fingerprints of SSH keys for multiple accounts"
  value       = { for k, v in module.oslogin_multiple_accounts : k => v.fingerprint }
}

output "expiring_key_info" {
  description = "Information about the expiring SSH key"
  value = {
    fingerprint = module.oslogin_expiring_key.fingerprint
    name        = module.oslogin_expiring_key.name
  }
}
