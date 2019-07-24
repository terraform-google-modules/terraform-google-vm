# preemptible_and_regular_instance_templates-simple

This creates instance templates for both preemptible VM and regular VM

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
| preemptible\_name | Name of the preemptible instance templates |
| preemptible\_self\_link | Self-link to the preemptible instance template |
| regular\_name | Name of the regular instance templates |
| regular\_self\_link | Self-link to the regular instance template |

[^]: (autogen_docs_end)