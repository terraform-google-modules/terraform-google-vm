# instance-template-simple

This is a simple, minimal example of how to use the instance_template module.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_path | The path to the GCP credentials JSON file | string | n/a | yes |
| labels | Labels, provided as a map | map | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | n/a | yes |
| service\_account | Service account email address and scopes | map | n/a | yes |
| subnetwork | The name of the subnetwork create this instance in. | string | `""` | no |
| tags | Network tags, provided as a list | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the instance templates |
| self\_link | Self-link to the instance template |

[^]: (autogen_docs_end)