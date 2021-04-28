# Instance with tags

This example creates a VM instance with network tags.
Tags enable you to make firewall rules and routes applicable to
specific VM instances.

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
| tags | Tags added to VM instance |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
