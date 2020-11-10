# instance-template-simple

This is a simple, minimal example of how to use the instance_template module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| labels | Labels, provided as a map | `map(string)` | n/a | yes |
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The name of the subnetwork create this instance in. | `string` | `""` | no |
| tags | Network tags, provided as a list | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the instance templates |
| self\_link | Self-link to the instance template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
