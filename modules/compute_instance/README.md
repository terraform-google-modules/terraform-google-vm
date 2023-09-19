# Compute Instance

This module is used to create compute instances (and only compute instances) using
[google_compute_instance_from_template](https://www.terraform.io/docs/providers/google/r/compute_instance_from_template), with no instance groups.

## Usage

See the [simple](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/examples/compute_instance/simple) for a usage example.

## Testing


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | <pre>list(object({<br>    nat_ip       = string<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| add\_hostname\_suffix | Adds a suffix to the hostname | `bool` | `true` | no |
| alias\_ip\_ranges | (Optional) An array of alias IP ranges for this network interface. Can only be specified for network interfaces on subnet-mode networks. | <pre>list(object({<br>    ip_cidr_range         = string<br>    subnetwork_range_name = string<br>  }))</pre> | `[]` | no |
| deletion\_protection | Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully. | `bool` | `false` | no |
| hostname | Hostname of instances | `string` | `""` | no |
| hostname\_suffix\_separator | Separator character to compose hostname when add\_hostname\_suffix is set to true. | `string` | `"-"` | no |
| instance\_template | Instance template self\_link used to create compute instances | `string` | n/a | yes |
| ipv6\_access\_config | IPv6 access configurations. Currently a max of 1 IPv6 access configuration is supported. If not specified, the instance will have no external IPv6 Internet access. | <pre>list(object({<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| labels | (Optional) Labels to override those from the template, provided as a map | `map(string)` | `null` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| num\_instances | Number of instances to create. This value is ignored if static\_ips is provided. | `number` | `"1"` | no |
| region | Region where the instances should be created. | `string` | `null` | no |
| resource\_manager\_tags | (Optional) A tag is a key-value pair that can be attached to a Google Cloud resource. You can use tags to conditionally allow or deny policies based on whether a resource has a specific tag. This value is not returned by the API. In Terraform, this value cannot be updated and changing it will recreate the resource. | `map(string)` | `null` | no |
| resource\_policies | (Optional) A list of short names or self\_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported. | `list(string)` | `[]` | no |
| static\_ips | List of static IPs for VM instances | `list(string)` | `[]` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | `string` | `""` | no |
| zone | Zone where the instances should be created. If not specified, instances will be spread across available zones in the region. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_details | List of all details for compute instances |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
