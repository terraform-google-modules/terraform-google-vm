# Unmanaged Instance Group (UMIG)

This is a module to spin up N number of compute instances with an unmanaged instance group, where N is either:
1. the number of static IPs in the `var.static_ips` input list, or
2. the number of instances specified in `var.num_instances`.


## Example usage

See the [simple](examples/umig/simple) test fixture example for usage.

## Testing


[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| hostname | Hostname of instances | string | `""` | no |
| instance\_template | Instance template self_link used to create compute instances | string | n/a | yes |
| named\_ports | Named name and named port | list | `<list>` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| num\_instances | Number of instances to create. This value is ignored if static_ips is provided. | string | `"1"` | no |
| static\_ips | List of static IPs for VM instances | list | `<list>` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | string | `""` | no |
| umig\_enabled | Enable this UMIG module. | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_self\_links | List of self_links for compute instances |
| umig\_self\_links | List of self_links for unmanaged instance groups |

[^]: (autogen_docs_end)