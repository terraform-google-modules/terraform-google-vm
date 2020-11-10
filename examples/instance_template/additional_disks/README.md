# instance-template-additional-disks

This example demonstrates how to use the instance_template module to create
instance templates with additional persistent disks.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | `null` | no |
| subnetwork | The name of the subnetwork create this instance in. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the instance templates |
| self\_link | Self-link to the instance template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
