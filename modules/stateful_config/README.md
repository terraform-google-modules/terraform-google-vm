## Providers

| Name | Version |
|------|---------|
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| mig\_name | Managed instance group name to attach instances to. | `string` | n/a | yes |
| minimal\_action | The minimal action to perform on the instance during an update. | `string` | `"NONE"` | no |
| most\_disruptive\_allowed\_action | The most disruptive action to perform on the instance during an update. | `string` | `"REPLACE"` | no |
| name\_prefix | Name prefix for the instances | `string` | n/a | yes |
| num\_instances | Number of stateful instances. | `number` | `1` | no |
| project\_id | The GCP project ID | `string` | n/a | yes |
| region | Region where the instances should be created. | `string` | n/a | yes |
| stateful\_disks | List of maps of stateful disks. | <pre>list(object({<br>    device_name = string<br>    source      = string<br>    delete_rule = string<br>    mode        = string<br>  }))<br></pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_names | Names of stateful instances |

