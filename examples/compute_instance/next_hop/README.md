# Instance as next hop for a route

This example creates a VM instance with IP forwarding enabled so that the
VM can forward a packet originated by another VM.

To use a VM as a next hop for a route, the VM needs to receive packets that have
destinations other than itself. Because it forwards those packets, the packet
sources are different from its own internal IP address. To accomplish this, you
must enable IP forwarding for the VM. When IP forwarding is enabled, Google
Cloud does not enforce packet source and destination checking.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The Google Cloud project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_self\_link | The URI of the instance rule  being created |
| network\_name | The name of the VPC network where the VM instance is created |
| project\_id | Google Cloud project ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
