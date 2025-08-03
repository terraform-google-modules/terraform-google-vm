# confidential computing with GPU

This is an example of a VM with GPU, using confidential computing,
encrypted disk using a multiregion (US by default) Cloud HSM key
and a custom service account with cloud-platform scope. It creates
the VM with a startup script that installs Nvidia H100 drivers and
enables confidential computing on the GPU.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key | Key name. | `string` | n/a | yes |
| keyring | Keyring name. | `string` | n/a | yes |
| location | Location for the resources (keyring, key, network, etc.). | `string` | `"us"` | no |
| project\_id | The Google Cloud project ID. | `string` | n/a | yes |
| region | The GCP region to create and test resources in. | `string` | `"us-central1"` | no |
| service\_account\_roles | Predefined roles for the Service account that will be created for the VM. Remember to follow principles of least privileges with Cloud IAM. | `list(string)` | `[]` | no |
| subnetwork | The subnetwork selflink to host the compute instances in. | `string` | n/a | yes |
| suffix | A suffix to be used as an identifier for resources. (e.g., suffix for KMS Key, Keyring). | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_self\_link | Self-link for compute instance. |
| name | Name of the instance templates. |
| self\_link | Self-link to the instance template. |
| suffix | Suffix used as an identifier for resources. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
