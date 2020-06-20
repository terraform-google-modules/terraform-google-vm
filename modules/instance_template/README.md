# instance_template

This submodule allows you to create a `google_compute_instance_template`
resource, which is used as the basis for the other instance, managed, and
unmanaged instance groups submodules.

## Usage

See the [simple](../../examples/instance_template/simple) for a usage example.

## Testing

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | object | `<list>` | no |
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name | object | `<list>` | no |
| auto\_delete | Whether or not the boot disk should be auto-deleted | string | `"true"` | no |
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | string | `"false"` | no |
| disk\_size\_gb | Boot disk size in GB | string | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | string | `"pd-standard"` | no |
| enable\_shielded\_vm | Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images | string | `"false"` | no |
| labels | Labels, provided as a map | map(string) | `<map>` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | string | `"n1-standard-1"` | no |
| metadata | Metadata, provided as a map | map(string) | `<map>` | no |
| name\_prefix | Name prefix for the instance template | string | `"default-instance-template"` | no |
| network | The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | string | `""` | no |
| preemptible | Allow the instance to be preempted | bool | `"false"` | no |
| project\_id | The GCP project ID | string | `"null"` | no |
| region | Region where the instance template should be created. | string | `"null"` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | object | n/a | yes |
| shielded\_instance\_config | Not used unless enable_shielded_vm is true. Shielded VM configuration for the instance. | object | `<map>` | no |
| source\_image | Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image. | string | `""` | no |
| source\_image\_family | Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image. | string | `"centos-7"` | no |
| source\_image\_project | Project where the source image comes from. The default project contains images that support Shielded VMs if desired | string | `"gce-uefi-images"` | no |
| startup\_script | User startup script to run when instances spin up | string | `""` | no |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | string | `""` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used. | string | `""` | no |
| tags | Network tags, provided as a list | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of instance template |
| self\_link | Self-link of instance template |
| tags | Tags that will be associated with instance(s) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
