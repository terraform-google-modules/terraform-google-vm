# vm-autoscaler

This is an example of how to use the MIG module to create a managed instance
group with an autoscaler.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute\_autoscaler.html#cpu\_utilization | list | n/a | yes |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | string | n/a | yes |
| credentials\_path | The path to the GCP credentials JSON file | string | n/a | yes |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | string | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | n/a | yes |
| service\_account | Service account email address and scopes | map | n/a | yes |
| subnetwork | The subnetwork to host the compute instances in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_template\_self\_link | Self-link of instance template |
| mig\_self\_link | Self-link for managed instance group |

[^]: (autogen_docs_end)