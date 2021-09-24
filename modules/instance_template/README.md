# instance_template

This submodule allows you to create a `google_compute_instance_template`
resource, which is used as the basis for the other instance, managed, and
unmanaged instance groups submodules.

## Usage

See the [simple](../../examples/instance_template/simple) for a usage example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | <pre>list(object({<br>    nat_ip       = string<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name | <pre>list(object({<br>    disk_name    = string<br>    device_name  = string<br>    auto_delete  = bool<br>    boot         = bool<br>    disk_size_gb = number<br>    disk_type    = string<br>    disk_labels  = map(string)<br>  }))</pre> | `[]` | no |
| additional\_networks | Additional network interface details for GCE, if any. | <pre>list(object({<br>    network            = string<br>    subnetwork         = string<br>    subnetwork_project = string<br>    network_ip         = string<br>    access_config = list(object({<br>      nat_ip       = string<br>      network_tier = string<br>    }))<br>  }))</pre> | `[]` | no |
| alias\_ip\_range | An array of alias IP ranges for this network interface. Can only be specified for network interfaces on subnet-mode networks.<br>ip\_cidr\_range: The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. At the time of writing only a netmask (e.g. /24) may be supplied, with a CIDR format resulting in an API error.<br>subnetwork\_range\_name: The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used. | <pre>object({<br>    ip_cidr_range         = string<br>    subnetwork_range_name = string<br>  })</pre> | `null` | no |
| auto\_delete | Whether or not the boot disk should be auto-deleted | `string` | `"true"` | no |
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | `string` | `"false"` | no |
| disk\_encryption\_key | The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance | `string` | `null` | no |
| disk\_labels | Labels to be assigned to boot disk, provided as a map | `map(string)` | `{}` | no |
| disk\_size\_gb | Boot disk size in GB | `string` | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | `string` | `"pd-standard"` | no |
| enable\_confidential\_vm | Whether to enable the Confidential VM configuration on the instance. Note that the instance image must support Confidential VMs. See https://cloud.google.com/compute/docs/images | `bool` | `false` | no |
| enable\_shielded\_vm | Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images | `bool` | `false` | no |
| gpu | GPU information. Type and count of GPU to attach to the instance template. See https://cloud.google.com/compute/docs/gpus more details | <pre>object({<br>    type  = string<br>    count = number<br>  })</pre> | `null` | no |
| labels | Labels, provided as a map | `map(string)` | `{}` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | `string` | `"n1-standard-1"` | no |
| metadata | Metadata, provided as a map | `map(string)` | `{}` | no |
| min\_cpu\_platform | Specifies a minimum CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. See the complete list: https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform | `string` | `null` | no |
| name\_prefix | Name prefix for the instance template | `string` | `"default-instance-template"` | no |
| network | The name or self\_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | `string` | `""` | no |
| network\_ip | Private IP address to assign to the instance if desired. | `string` | `""` | no |
| on\_host\_maintenance | Instance availability Policy | `string` | `"MIGRATE"` | no |
| preemptible | Allow the instance to be preempted | `bool` | `false` | no |
| project\_id | The GCP project ID | `string` | `null` | no |
| region | Region where the instance template should be created. | `string` | `null` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account. | <pre>object({<br>    email  = string<br>    scopes = set(string)<br>  })</pre> | n/a | yes |
| shielded\_instance\_config | Not used unless enable\_shielded\_vm is true. Shielded VM configuration for the instance. | <pre>object({<br>    enable_secure_boot          = bool<br>    enable_vtpm                 = bool<br>    enable_integrity_monitoring = bool<br>  })</pre> | <pre>{<br>  "enable_integrity_monitoring": true,<br>  "enable_secure_boot": true,<br>  "enable_vtpm": true<br>}</pre> | no |
| source\_image | Source disk image. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | `string` | `""` | no |
| source\_image\_family | Source image family. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | `string` | `"centos-7"` | no |
| source\_image\_project | Project where the source image comes from. The default project contains CentOS images. | `string` | `"centos-cloud"` | no |
| startup\_script | User startup script to run when instances spin up | `string` | `""` | no |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | `string` | `""` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used. | `string` | `""` | no |
| tags | Network tags, provided as a list | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of instance template |
| self\_link | Self-link of instance template |
| tags | Tags that will be associated with instance(s) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
