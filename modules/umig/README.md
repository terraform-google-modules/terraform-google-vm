# Unmanaged Instance Group (UMIG)

This module is used to create compute instances using
[google_compute_instance_from_template](https://www.terraform.io/docs/providers/google/r/compute_instance_from_template.html), and [google_compute_instance_groups](https://www.terraform.io/docs/providers/google/r/compute_instance_group.html).

## Usage

See the [simple](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/examples/umig/simple) for a usage example.

## Testing


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | <pre>list(list(object({<br>    nat_ip       = string<br>    network_tier = string<br>  })))</pre> | `[]` | no |
| additional\_networks | Additional network interface details for GCE, if any. | <pre>list(object({<br>    network            = string<br>    subnetwork         = string<br>    subnetwork_project = string<br>    network_ip         = string<br>    access_config = list(object({<br>      nat_ip       = string<br>      network_tier = string<br>    }))<br>  }))</pre> | `[]` | no |
| hostname | Hostname of instances | `string` | `""` | no |
| instance\_template | Instance template self\_link used to create compute instances | `any` | n/a | yes |
| named\_ports | Named name and named port | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | `[]` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| num\_instances | Number of instances to create. This value is ignored if static\_ips is provided. | `string` | `"1"` | no |
| project\_id | The GCP project ID | `string` | `null` | no |
| region | The GCP region where the unmanaged instance group resides. | `string` | n/a | yes |
| static\_ips | List of static IPs for VM instances | `list(string)` | `[]` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_details | List of all details for compute instances |
| instances\_self\_links | List of self-links for compute instances |
| self\_links | List of self-links for unmanaged instance groups |
| umig\_details | List of all details for unmanaged instance groups |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
