# disk-snapshot

This is a simple example of how to use the compute_disk_snapshot module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| subnetwork | The subnetwork selflink to host the compute instances in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| disk\_snapshots | List of disks snapshots and the snapshot policy |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
