# terraform-google-vm

This is a collection of opinionated submodules that can be used as building blocks to provision VMs in GCP:

* [Instance template](modules/instance_template)
* [Managed instance group](modules/mig)
* [Unmanaged instance group](modules/umig)

## Compatibility
This module is meant for use with Terraform 1.3+ and tested using Terraform 1.3+. If you find incompatibilities using Terraform >=1.3, please open an issue.

If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v5.1.0](https://registry.terraform.io/modules/terraform-google-modules/-vm/google/v5.1.0).

Terraform compatibility:

| Module Version        | Terraform Version Required |
|-----------------------|----------------------------|
| >= 12.0.0             | >= 1.3.0                   |
| >= 6.0.0 and < 12.0.0 | 0.13 or greater            |
| <= 5.1.0              | 0.12                       |

## Examples

Examples of how to use these modules can be found in the [examples](examples) folder.

## Project APIs

The following APIs must be enabled on your project:
- `compute.googleapis.com`
- `iam.googleapis.com`

See also the [project_services](modules/project_services) module (optional).

## Notes

`distribution_policy_zones` cannot be changed during use.
If you have changed them yourself or used to have a default value, then you'll have to force recreate a MIG group yourself.

## Tests

For running the integration test cases, please refer to the [CONTRIBUTING](CONTRIBUTING.md) documentation.

## Permissions

The service account used to execute tests for this module should have the following roles:
- [`roles/compute.admin`](https://cloud.google.com/iam/docs/understanding-roles#compute-engine-roles)
- [`roles/iam.serviceAccountUser`](https://cloud.google.com/iam/docs/understanding-roles#service-accounts-roles)
