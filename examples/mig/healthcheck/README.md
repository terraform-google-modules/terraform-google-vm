# vm-autoscaler

This is an example of how to use the MIG module to create a managed instance
group with an autoscaler.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account. | <pre>object({<br>    email  = string,<br>    scopes = set(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_template\_self\_link | Self-link of instance template |
| mig\_self\_link | Self-link for managed instance group |
| region | The GCP region to create and test resources in |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
