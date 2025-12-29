# OS Login SSH Public Key Module

This module allows you to manage SSH public keys for OS Login on Google Cloud Platform. It enables you to associate SSH keys with user accounts and service accounts without impersonation, addressing the limitations described in [Issue #548](https://github.com/terraform-google-modules/terraform-google-vm/issues/548).

## Features

- Associate SSH public keys with service accounts using the OS Login API
- Optionally set expiration times for SSH keys
- Support for multiple SSH keys per user/service account
- No impersonation required - works directly with service account credentials

## Usage

### Basic Example

```hcl
module "oslogin_key" {
  source = "terraform-google-modules/vm/google//modules/oslogin"

  user = "my-service-account@my-project.iam.gserviceaccount.com"
  key  = file("~/.ssh/id_rsa.pub")
}
```

### Example with Expiration

```hcl
module "oslogin_key_expiring" {
  source = "terraform-google-modules/vm/google//modules/oslogin"

  user                  = "my-service-account@my-project.iam.gserviceaccount.com"
  key                   = file("~/.ssh/id_rsa.pub")
  project_id            = "my-project-id"
  expiration_time_usec  = "1735689600000000"  # Expires on 2025-01-01 00:00:00 UTC
}
```

### Managing Multiple Keys

```hcl
locals {
  service_accounts = [
    "sa-1@my-project.iam.gserviceaccount.com",
    "sa-2@my-project.iam.gserviceaccount.com",
    "sa-3@my-project.iam.gserviceaccount.com"
  ]
}

module "oslogin_keys" {
  source   = "terraform-google-modules/vm/google//modules/oslogin"
  for_each = toset(local.service_accounts)

  user = each.value
  key  = file("~/.ssh/id_rsa.pub")
}
```

## Prerequisites

### Required APIs

The following API must be enabled on your project:
- `oslogin.googleapis.com`

You can enable it using the following command:
```bash
gcloud services enable oslogin.googleapis.com --project=YOUR_PROJECT_ID
```

### Required Permissions

The service account used to execute Terraform must have one of the following roles:
- `roles/compute.osLogin` - For managing your own SSH keys
- `roles/compute.osAdminLogin` - For managing SSH keys for other users/service accounts

Additionally, to manage SSH keys for service accounts, you need:
- `roles/iam.serviceAccountUser` - On the target service account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| user | The user email, such as a service account email | `string` | n/a | yes |
| key | The public SSH key content | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs | `string` | `null` | no |
| expiration\_time\_usec | An expiration time in microseconds since epoch | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| fingerprint | The SHA-256 fingerprint of the SSH public key |
| name | The canonical resource name |
| expiration\_time\_usec | The expiration time in microseconds since epoch |

## Notes

- The `key` parameter should contain the full SSH public key, including the key type (e.g., `ssh-rsa`, `ssh-ed25519`)
- The `expiration_time_usec` must be in microseconds since Unix epoch (multiply seconds by 1,000,000)
- When using with service accounts, ensure OS Login is enabled on the target VMs
- This module uses the `google_os_login_ssh_public_key` resource which requires Terraform Google Provider version >= 4.0

## Examples

See the [examples](../../examples/oslogin) directory for more detailed examples.

## References

- [Google Cloud OS Login Documentation](https://cloud.google.com/compute/docs/oslogin)
- [Terraform google_os_login_ssh_public_key Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/os_login_ssh_public_key)
- [Issue #548 - OSLogin public SSH key provisioning](https://github.com/terraform-google-modules/terraform-google-vm/issues/548)
