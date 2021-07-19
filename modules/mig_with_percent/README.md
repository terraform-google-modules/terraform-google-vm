# Managed Instance Group (MIG) with percent

This module allows you to set the percentage ratio of second version of instance template on Managed Instance Group.

## Usage

See the [simple example](../../examples/mig_with_percent/simple) for a usage example.

## Upgrading

The current version is 2.X. The following guides are available to assist with upgrades:

- [1.X -> 2.0](../../docs/upgrading_to_mig_v2.0.md)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autoscaler\_name | Autoscaler name. When variable is empty, name will be derived from var.hostname. | `string` | `""` | no |
| autoscaling\_cpu | Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization | `list(map(number))` | `[]` | no |
| autoscaling\_enabled | Creates an autoscaler for the managed instance group | `string` | `"false"` | no |
| autoscaling\_lb | Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization | `list(map(number))` | `[]` | no |
| autoscaling\_metric | Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric | <pre>list(object({<br>    name   = string<br>    target = number<br>    type   = string<br>  }))</pre> | `[]` | no |
| autoscaling\_scale\_in\_control | Autoscaling, scale-in control block. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#scale_in_control | <pre>object({<br>    fixed_replicas   = number<br>    percent_replicas = number<br>    time_window_sec  = number<br>  })</pre> | <pre>{<br>  "fixed_replicas": null,<br>  "percent_replicas": null,<br>  "time_window_sec": null<br>}</pre> | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | `number` | `60` | no |
| distribution\_policy\_zones | The distribution policy, i.e. which zone(s) should instances be create in. Default is all zones in given region. | `list(string)` | `[]` | no |
| health\_check | Health check to determine whether instances are responsive and able to do work | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    response            = string<br>    proxy_header        = string<br>    port                = number<br>    request             = string<br>    request_path        = string<br>    host                = string<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 1,<br>  "host": "",<br>  "initial_delay_sec": 30,<br>  "port": 80,<br>  "proxy_header": "NONE",<br>  "request": "",<br>  "request_path": "/",<br>  "response": "",<br>  "timeout_sec": 10,<br>  "type": "",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| health\_check\_name | Health check name. When variable is empty, name will be derived from var.hostname. | `string` | `""` | no |
| hostname | Hostname prefix for instances | `string` | `"default"` | no |
| instance\_template\_initial\_version | Instance template self\_link used to create compute instances for the initial version | `any` | n/a | yes |
| instance\_template\_next\_version | Instance template self\_link used to create compute instances for the second version | `any` | n/a | yes |
| max\_replicas | The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas. | `number` | `10` | no |
| mig\_name | Managed instance group name. When variable is empty, name will be derived from var.hostname. | `string` | `""` | no |
| mig\_timeouts | Times for creation, deleting and updating the MIG resources. Can be helpful when using wait\_for\_instances to allow a longer VM startup time. | <pre>object({<br>    create = string<br>    update = string<br>    delete = string<br>  })</pre> | <pre>{<br>  "create": "5m",<br>  "delete": "15m",<br>  "update": "5m"<br>}</pre> | no |
| min\_replicas | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | `number` | `2` | no |
| named\_ports | Named name and named port. https://cloud.google.com/load-balancing/docs/backend-service#named_ports | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | `[]` | no |
| network | Network to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| next\_version\_percent | Percentage of instances defined in the second version | `any` | n/a | yes |
| project\_id | The GCP project ID | `string` | `null` | no |
| region | The GCP region where the managed instance group resides. | `any` | n/a | yes |
| stateful\_disks | Disks created on the instances that will be preserved on instance delete. https://cloud.google.com/compute/docs/instance-groups/configuring-stateful-disks-in-migs | <pre>list(object({<br>    device_name = string<br>    delete_rule = string<br>  }))</pre> | `[]` | no |
| subnetwork | Subnet to deploy to. Only one of network or subnetwork should be specified. | `string` | `""` | no |
| subnetwork\_project | The project that subnetwork belongs to | `string` | `""` | no |
| target\_pools | The target load balancing pools to assign this group to. | `list(string)` | `[]` | no |
| target\_size | The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | `number` | `1` | no |
| update\_policy | The rolling update policy. https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html#rolling_update_policy | <pre>list(object({<br>    max_surge_fixed              = number<br>    instance_redistribution_type = string<br>    max_surge_percent            = number<br>    max_unavailable_fixed        = number<br>    max_unavailable_percent      = number<br>    min_ready_sec                = number<br>    replacement_method           = string<br>    minimal_action               = string<br>    type                         = string<br>  }))</pre> | `[]` | no |
| wait\_for\_instances | Whether to wait for all instances to be created/updated before returning. Note that if this is set to true and the operation does not succeed, Terraform will continue trying until it times out. | `string` | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| health\_check\_self\_links | All self\_links of healthchecks created for the instance group. |
| instance\_group | Instance-group url of managed instance group |
| instance\_group\_manager | An instance of google\_compute\_region\_instance\_group\_manager of the instance group. |
| self\_link | Self-link of managed instance group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
