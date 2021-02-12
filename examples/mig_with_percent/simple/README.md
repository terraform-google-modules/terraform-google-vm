# mig_with_percent-simple

This is a simple, minimal example of how to use the MIG with percent module to create a
managed instance group.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account email address and scopes | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The subnetwork to host the compute instances in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| preemptible\_self\_link | Self-link of preemptible instance template |
| region | The GCP region to create and test resources in |
| regular\_self\_link | Self-link of regular instance template |
| self\_link | Self-link of the managed instance group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
