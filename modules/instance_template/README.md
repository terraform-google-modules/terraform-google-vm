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
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. | <pre>list(object({<br>    nat_ip       = optional(string)<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#disk_name | <pre>list(object({<br>    auto_delete     = optional(bool, true)<br>    boot            = optional(bool, false)<br>    device_name     = optional(string)<br>    disk_name       = optional(string)<br>    disk_size_gb    = optional(number)<br>    disk_type       = optional(string)<br>    disk_labels     = optional(map(string), {})<br>    interface       = optional(string)<br>    mode            = optional(string)<br>    source          = optional(string)<br>    source_image    = optional(string)<br>    source_snapshot = optional(string)<br>  }))</pre> | `[]` | no |
| additional\_networks | Additional network interface details for GCE, if any. | <pre>list(object({<br>    network            = optional(string)<br>    subnetwork         = optional(string)<br>    subnetwork_project = optional(string)<br>    network_ip         = optional(string)<br>    nic_type           = optional(string)<br>    stack_type         = optional(string)<br><br>    # New Fields<br>    queue_count        = optional(number) # Multi-queue count (Rx/Tx)<br>    network_attachment = optional(string) # Consumer link for PSC-I<br>    vlan               = optional(number) # VLAN tag (2-255)<br><br>    # Access Config (External IPv4)<br>    access_config = optional(list(object({<br>      nat_ip       = optional(string)<br>      network_tier = optional(string) # PREMIUM or STANDARD<br>    })), [])<br><br>    # IPv6 Access Config (External IPv6)<br>    ipv6_access_config = optional(list(object({<br>      network_tier = string # Always PREMIUM for IPv6<br>    })), [])<br><br>    # Alias IP Ranges (Secondary ranges)<br>    alias_ip_range = optional(list(object({<br>      ip_cidr_range         = string<br>      subnetwork_range_name = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| alias\_ip\_range | An array of alias IP ranges for this network interface. Can only be specified for network interfaces on subnet-mode networks.<br>ip\_cidr\_range: The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. At the time of writing only a netmask (e.g. /24) may be supplied, with a CIDR format resulting in an API error.<br>subnetwork\_range\_name: The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used. | <pre>object({<br>    ip_cidr_range         = string<br>    subnetwork_range_name = string<br>  })</pre> | `null` | no |
| auto\_delete | Whether or not the boot disk should be auto-deleted | `string` | `"true"` | no |
| automatic\_restart | (Optional) Specifies whether the instance should be automatically restarted if it is terminated by Compute Engine (not terminated by a user). | `bool` | `true` | no |
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | `string` | `"false"` | no |
| confidential\_instance\_type | Defines the confidential computing technology the instance uses. If this is set to "SEV\_SNP", var.min\_cpu\_platform will be automatically set to "AMD Milan". See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#confidential_instance_type. | `string` | `null` | no |
| create\_service\_account | Create a new service account to attach to the instance. This is alternate to providing the service\_account input variable. Please provide the service\_account input if setting this to false. | `bool` | `true` | no |
| description | The template's description | `string` | `""` | no |
| disk\_encryption\_key | The id of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance | `string` | `null` | no |
| disk\_labels | Labels to be assigned to boot disk, provided as a map | `map(string)` | `{}` | no |
| disk\_resource\_policies | A list (short name or id) of resource policies to attach to this disk for automatic snapshot creations | `list(string)` | `[]` | no |
| disk\_size\_gb | Boot disk size in GB | `string` | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | `string` | `"pd-standard"` | no |
| enable\_confidential\_vm | Whether to enable the Confidential VM configuration on the instance. Note that the instance image must support Confidential VMs. See https://cloud.google.com/compute/docs/images | `bool` | `false` | no |
| enable\_nested\_virtualization | Defines whether the instance should have nested virtualization enabled. | `bool` | `false` | no |
| enable\_shielded\_vm | Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images | `bool` | `false` | no |
| gpu | GPU information. Type and count of GPU to attach to the instance template. See https://cloud.google.com/compute/docs/gpus more details | <pre>object({<br>    type  = string<br>    count = number<br>  })</pre> | `null` | no |
| instance\_description | Description of the generated instances | `string` | `""` | no |
| ipv6\_access\_config | IPv6 access configurations. Currently a max of 1 IPv6 access configuration is supported. If not specified, the instance will have no external IPv6 Internet access. | <pre>list(object({<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| labels | Labels, provided as a map | `map(string)` | `{}` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | `string` | `"n1-standard-1"` | no |
| maintenance\_interval | Specifies the frequency of planned maintenance events | `string` | `null` | no |
| metadata | Metadata, provided as a map | `map(string)` | `{}` | no |
| min\_cpu\_platform | Specifies a minimum CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. See the complete list: https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform | `string` | `null` | no |
| name\_prefix | Name prefix for the instance template | `string` | `"default-instance-template"` | no |
| network | The name or self\_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | `string` | `""` | no |
| network\_attachment | The self\_link of the network attachment for PSC-I connection. | `string` | `null` | no |
| network\_ip | Private IP address to assign to the instance if desired. | `string` | `""` | no |
| nic\_type | Valid values are "VIRTIO\_NET", "GVNIC" or set to null to accept API default behavior. | `string` | `null` | no |
| on\_host\_maintenance | Instance availability Policy | `string` | `"MIGRATE"` | no |
| preemptible | Allow the instance to be preempted | `bool` | `false` | no |
| project\_id | The GCP project ID | `string` | n/a | yes |
| region | Region where the instance template should be created. | `string` | n/a | yes |
| resource\_manager\_tags | (Optional) A set of key/value resource manager tag pairs to bind to the instances. Keys must be in the format tagKeys/{tag\_key\_id}, and values are in the format tagValues/456 | `map(string)` | `null` | no |
| resource\_policies | A list of self\_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported. | `list(string)` | `[]` | no |
| service\_account | Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account. | <pre>object({<br>    email  = string<br>    scopes = optional(set(string), ["cloud-platform"])<br>  })</pre> | `null` | no |
| service\_account\_project\_roles | Roles to grant to the newly created cloud run SA in specified project. Should be used with create\_service\_account set to true and no input for service\_account | `list(string)` | `[]` | no |
| shielded\_instance\_config | Not used unless enable\_shielded\_vm is true. Shielded VM configuration for the instance. | <pre>object({<br>    enable_secure_boot          = bool<br>    enable_vtpm                 = bool<br>    enable_integrity_monitoring = bool<br>  })</pre> | <pre>{<br>  "enable_integrity_monitoring": true,<br>  "enable_secure_boot": true,<br>  "enable_vtpm": true<br>}</pre> | no |
| source\_image | Source disk image. If neither source\_image nor source\_image\_family is specified, defaults to the latest public Rocky Linux 9 optimized for GCP image. | `string` | `""` | no |
| source\_image\_family | Source image family. If neither source\_image nor source\_image\_family is specified, defaults to the latest public Rocky Linux 9 optimized for GCP image. | `string` | `"rocky-linux-9-optimized-gcp"` | no |
| source\_image\_project | Project where the source image comes from. The default project contains Rocky Linux images. | `string` | `"rocky-linux-cloud"` | no |
| spot | Provision a SPOT instance | `bool` | `false` | no |
| spot\_instance\_termination\_action | Action to take when Compute Engine preempts a Spot VM. | `string` | `"STOP"` | no |
| stack\_type | The stack type for this network interface to identify whether the IPv6 feature is enabled or not. Values are `IPV4_IPV6` or `IPV4_ONLY`. Default behavior is equivalent to IPV4\_ONLY. | `string` | `null` | no |
| startup\_script | User startup script to run when instances spin up | `string` | `""` | no |
| subnets | Optional: A map containing subnet details Used to derive the subnetwork URI if subnetwork is not provided. | <pre>list(object({<br>    id      = string<br>    region  = string<br>    purpose = string<br>  }))</pre> | `[]` | no |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | `string` | `""` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used. | `string` | `""` | no |
| tags | Network tags, provided as a list | `list(string)` | `[]` | no |
| threads\_per\_core | The number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1. | `number` | `null` | no |
| total\_egress\_bandwidth\_tier | Egress bandwidth tier setting for supported VM families | `string` | `"DEFAULT"` | no |
| vlan | The VLAN ID for the primary network interface (Dynamic NIC), must be an integer from 2 to 255. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of instance template |
| network\_interface\_details | The names and VLAN tags of the template interfaces. |
| self\_link | Self-link of instance template |
| self\_link\_unique | Unique self-link of instance template (recommended output to use instead of self\_link) |
| service\_account\_info | Service account id and email |
| tags | Tags that will be associated with instance(s) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
