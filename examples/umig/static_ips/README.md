# umig-static-ips

This is an example to demonstrate how to use the UMIG module to create unmanaged
instance groups with user-specified static IPs.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| num\_instances | Number of instances to create | `string` | `"1"` | no |
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| static\_ips | List of static IPs for VM instances | `list(string)` | n/a | yes |
| subnetwork | The subnetwork to host the compute instances in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_self\_links | List of self-links for compute instances |
| self\_links | List of self-links of unmanaged instance groups |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
