# vm-autoscaler

This is an example of how to use the MIG module to create a managed instance
group with an autoscaler.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization | `list(map(number))` | n/a | yes |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | `any` | n/a | yes |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | `any` | n/a | yes |
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The subnetwork to host the compute instances in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_template\_self\_link | Self-link of instance template |
| mig\_self\_link | Self-link for managed instance group |
| region | The GCP region to create and test resources in |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
