# preemptible_and_regular_instance_templates

This submodule allows you to create two `google_compute_instance_template`
resources, that consist of preemptible and regular VMs.

## Usage

See the [simple](examples/preemptible_and_regular_instance_templates/simple) for a usage example.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute\_instance\_template.html#disk\_name | list | `<list>` | no |
| auto\_delete | Whether or not the boot disk should be auto-deleted | string | `"true"` | no |
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | string | `"false"` | no |
| disk\_size\_gb | Boot disk size in GB | string | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | string | `"pd-standard"` | no |
| labels | Labels, provided as a map | map | `<map>` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | string | `"n1-standard-1"` | no |
| metadata | Metadata, provided as a map | map | `<map>` | no |
| name\_prefix | Name prefix for the instance template | string | `"default-instance-template"` | no |
| network | The name or self\_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | string | `""` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute\_instance\_template.html#service\_account. | map | n/a | yes |
| source\_image | Source disk image. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | string | `""` | no |
| source\_image\_family | Source image family. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | string | `""` | no |
| source\_image\_project | Project where the source image comes from | string | `""` | no |
| startup\_script | User startup script to run when instances spin up | string | `""` | no |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | string | `""` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used. | string | `""` | no |
| tags | Network tags, provided as a list | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| preemptible\_name |  |
| preemptible\_self\_link |  |
| regular\_name |  |
| regular\_self\_link |  |

[^]: (autogen_docs_end)