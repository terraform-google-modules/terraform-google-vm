# Compute Instance

This module is used to create compute instances (and only compute instances) using
[google_compute_instance_from_template](https://www.terraform.io/docs/providers/google/r/compute_instance_from_template.html), with no instance groups.

## Usage

See the [simple](examples/compute_instance/simple) for a usage example.

## Testing


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | object | `<list>` | no |
| hostname | Hostname of instances | string | `""` | no |
| instance\_template | Instance template self_link used to create compute instances | string | n/a | yes |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| num\_instances | Number of instances to create. This value is ignored if static_ips is provided. | string | `"1"` | no |
| region | Region where the instances should be created. | string | `"null"` | no |
| static\_ips | List of static IPs for VM instances | list(string) | `<list>` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
