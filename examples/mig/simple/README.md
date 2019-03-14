# mig-simple

This is a simple, minimal example of how to use the MIG module to create a
managed instance group.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_path | The path to the GCP credentials JSON file | string | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | n/a | yes |
| service\_account | Service account email address and scopes | map | n/a | yes |
| subnetwork | The subnetwork to host the compute instances in | string | n/a | yes |
| target\_size | The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| self\_link | Self-link of the managed instance group |

[^]: (autogen_docs_end)