# vm-minimal

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_path | The path to the GCP credentials JSON file | string | n/a | yes |
| labels | Labels, provided as a map | map | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | n/a | yes |
| service\_account | Service account email address and scopes | map | n/a | yes |
| subnetwork | The subnetwork to host the compute instances in | string | n/a | yes |
| tags | Network tags, provided as a list | list | n/a | yes |

[^]: (autogen_docs_end)