# instance-template-additional-disks

This example demonstrates how to use the instance_template module to create
instance templates with additional persistent disks.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials\_path | The path to the GCP credentials JSON file | string | n/a | yes |
| project\_id | The GCP project to use for integration tests | string | n/a | yes |
| region | The GCP region to create and test resources in | string | n/a | yes |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute\_instance\_template.html#service\_account. | object | `"null"` | no |
| subnetwork | The name of the subnetwork create this instance in. | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the instance templates |
| self\_link | Self-link to the instance template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
