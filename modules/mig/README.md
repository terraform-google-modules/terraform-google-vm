# Managed Instance Group (MIG)

This module is used to create a [google_compute_region_instance_group_manager](https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html),
and optionally, an autoscaler and healthchecks.

## Usage

See the [simple example](../../examples/mig/simple) for a usage example.

## Upgrading

The current version is 2.X. The following guides are available to assist with upgrades:

- [1.X -> 2.0](../../docs/upgrading_to_mig_v2.0.md)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization | list(map(number)) | `<list>` | no |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | string | `"false"` | no |
| autoscaling\_lb | Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization | list(map(number)) | `<list>` | no |
| autoscaling\_metric | Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric | object | `<list>` | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | string | `"60"` | no |
| distribution\_policy\_zones | The distribution policy, i.e. which zone(s) should instances be create in. Default is all zones in given region. | list(string) | `<list>` | no |
| health\_check | Health check to determine whether instances are responsive and able to do work | object | `<map>` | no |
| hostname | Hostname prefix for instances | string | `"default"` | no |
| instance\_template | Instance template self_link used to create compute instances | string | n/a | yes |
| max\_replicas | The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas. | string | `"10"` | no |
| mig\_timeouts | Times for creation, deleting and updating the MIG resources. Can be helpful when using wait_for_instances to allow a longer VM startup time. | object | `<map>` | no |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | string | `"2"` | no |
| named\_ports | Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports | object | `<list>` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| project\_id | The GCP project ID | string | `"null"` | no |
| region | The GCP region where the managed instance group resides. | string | n/a | yes |
| stateful\_disks | Disks created on the instances that will be preserved on instance delete. https://cloud.google.com/compute/docs/instance-groups/configuring-stateful-disks-in-migs | object | `<list>` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | string | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | string | `""` | no |
| target\_pools | The target load balancing pools to assign this group to. | list(string) | `<list>` | no |
| target\_size | The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | string | `"1"` | no |
| update\_policy | The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html#rolling_update_policy | object | `<list>` | no |
| wait\_for\_instances | Whether to wait for all instances to be created/updated before returning. Note that if this is set to true and the operation does not succeed, Terraform will continue trying until it times out. | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_group | Instance-group url of managed instance group |
| self\_link | Self-link of managed instance group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
