# Instance with multiple interfaces

This example creates a VM instance with multiple network interfaces.
The subnets must be in the same region as the VM.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The Google Cloud project ID | `string` | n/a | yes |
| subnet\_1 | Self link to a subnetwork in the same region as the VM. | `string` | n/a | yes |
| subnet\_2 | Self link to a subnetwork in the same region as the VM. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_self\_link | The URI of the instance rule  being created |
| network\_name\_1 | The name of the VPC network where the VM's first network interface is created |
| network\_name\_2 | The name of the VPC network where the VM's second network interface is created |
| project\_id | Google Cloud project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
