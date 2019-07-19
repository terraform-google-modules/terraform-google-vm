# Managed Instance Group (MIG)

This module is used to create a [google_compute_region_instance_group_manager](https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html),
and optionally, an autoscaler and healthchecks.

## Usage

See the [simple example](../../examples/mig/simple) for a usage example.

## Testing

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute\_autoscaler.html#cpu\_utilization | list | `<list>` | no |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | string | `"false"` | no |
| autoscaling\_lb | Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute\_autoscaler.html#load\_balancing\_utilization | list | `<list>` | no |
| autoscaling\_metric | Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute\_autoscaler.html#metric | list | `<list>` | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | string | `"60"` | no |
| distribution\_policy\_zones | The distribution policy, i.e. which zone\(s\) should instances be create in. Default is all zones in given region. | list | `<list>` | no |
| hc\_healthy\_threshold | Health check healthy threshold. | string | `"1"` | no |
| hc\_initial\_delay\_sec | Health check, intial delay in seconds. | string | `"30"` | no |
| hc\_interval\_sec | Health check interval in seconds. | string | `"30"` | no |
| hc\_path | Health check http path to check. | string | `"/"` | no |
| hc\_port | Health check port. | string | `""` | no |
| hc\_timeout\_sec | Health check timeout in seconds. | string | `"10"` | no |
| hc\_unhealthy\_threshold | Health check unhealthy threshold. | string | `"5"` | no |
| hostname | Hostname prefix for instances | string | `"default"` | no |
| http\_healthcheck\_enable | Enable HTTP healthcheck | string | `"false"` | no |
| instance\_template | Instance template self\_link used to create compute instances | string | n/a | yes |
| max\_replicas | The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas. | string | `"10"` | no |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | string | `"2"` | no |
| named\_ports | Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named\_ports | list | `<list>` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| region | The GCP region where the managed instance group resides. | string | n/a | yes |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | string | `""` | no |
| target\_pools | The target load balancing pools to assign this group to. | list | `<list>` | no |
| target\_size | The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | string | `"1"` | no |
| tcp\_healthcheck\_enable | Enable TCP healthcheck | string | `"false"` | no |
| update\_policy | The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute\_region\_instance\_group\_manager.html#rolling\_update\_policy | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_group | Instance-group url of managed instance group |
| self\_link | Self-link of managed instance group |

[^]: (autogen_docs_end)