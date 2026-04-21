# MIG with instance_lifecycle_policy

This example creates a Managed Instance Group with `instance_lifecycle_policy` set to `DO_NOTHING`, preventing the MIG from automatically repairing or recreating instances that have been stopped externally.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The subnetwork to host the compute instances in | `string` | n/a | yes |
| target\_size | The target number of running instances for this managed instance group. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| region | The GCP region where the MIG was created |
| self\_link | Self-link of the managed instance group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
