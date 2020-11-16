# instance-simple

This is a simple, minimal example of how to use the compute_instance module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| nat\_ip | Public ip address | string | `"null"` | no |
| network\_tier | Network network_tier | string | `"PREMIUM"` | no |
| num\_instances | Number of instances to create | string | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | object | `"null"` | no |
| subnetwork | The subnetwork selflink to host the compute instances in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
