# instance-simple

This is a simple, minimal example of how to use the compute_instance module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| nat\_ip | Public ip address | `any` | `null` | no |
| network\_tier | Network network\_tier | `string` | `"PREMIUM"` | no |
| num\_instances | Number of instances to create | `any` | n/a | yes |
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string,<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The subnetwork selflink to host the compute instances in | `any` | n/a | yes |
| zone | The GCP zone to create resources in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
