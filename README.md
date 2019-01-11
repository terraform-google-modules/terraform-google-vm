# terraform-google-vm

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name | list | `<list>` | no |
| auto\_delete | Whether or not the disk should be auto-deleted | string | `"true"` | no |
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization | list | `<list>` | no |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | string | `"false"` | no |
| autoscaling\_lb | Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization | list | `<list>` | no |
| autoscaling\_metric | Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric | list | `<list>` | no |
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | string | `"false"` | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | string | `"60"` | no |
| disk\_size\_gb | Disk size in GB | string | `"100"` | no |
| disk\_type | Disk type, can be either pd-ssd, local-ssd, or pd-standard | string | `"pd-standard"` | no |
| distribution\_policy\_zones | The distribution policy, i.e. which zone(s) should instances be create in. Default is all zones in given region. | list | `<list>` | no |
| hc\_healthy\_threshold | Health check healthy threshold. | string | `"1"` | no |
| hc\_initial\_delay\_sec | Health check, intial delay in seconds. | string | `"30"` | no |
| hc\_interval\_sec | Health check interval in seconds. | string | `"30"` | no |
| hc\_path | Health check http path to check. | string | `"/"` | no |
| hc\_port | Health check port. | string | `""` | no |
| hc\_timeout\_sec | Health check timeout in seconds. | string | `"10"` | no |
| hc\_unhealthy\_threshold | Health check unhealthy threshold. | string | `"5"` | no |
| hostname | Hostname prefix for instances. | string | `"default"` | no |
| http\_healthcheck\_enable | Enable HTTP healthcheck | string | `"false"` | no |
| labels | Labels, provided as a map | map | `<map>` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | string | `"n1-standard-4"` | no |
| max\_replicas | The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas. | string | `"10"` | no |
| metadata | Metadata, provided as a map | map | `<map>` | no |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | string | `"2"` | no |
| name\_prefix | Name prefix for the instance template | string | `"default-instance-template"` | no |
| named\_ports | Named name and named port | list | `<list>` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| region | The GCP region where instances will be deployed. | string | n/a | yes |
| service\_account | Service account email address and scopes | map | n/a | yes |
| source\_image | Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image. | string | `""` | no |
| source\_image\_family | Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image. | string | `""` | no |
| source\_image\_project | Project where the source image comes from | string | `""` | no |
| startup\_script | User startup script to run when instances spin up | string | `""` | no |
| static\_ips | List of static IPs for VM instances. | list | `<list>` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | string | `""` | no |
| tags | Network tags, provided as a list | list | `<list>` | no |
| target\_pools | The target load balancing pools to assign this group to. | list | `<list>` | no |
| target\_size | The target number of running instances for this managed or unmanaged instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | string | `"1"` | no |
| tcp\_healthcheck\_enable | Enable TCP healthcheck | string | `"false"` | no |
| umig\_enabled | Enable this UMIG module. | string | `"false"` | no |
| update\_policy | The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html#rolling_update_policy | list | `<list>` | no |

[^]: (autogen_docs_end)