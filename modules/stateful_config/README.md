# Stateful Config

This module is used to create [google_compute_region_per_instance_config](https://www.terraform.io/docs/providers/google/r/compute_region_per_instance_config.html).

## Usage

See the [full example](../../examples/stateful_config/full) for a usage example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| mig\_name | Managed instance group name to attach instances to. | string | n/a | yes |
| minimal\_action | The minimal action to perform on the instance during an update. | string | `"NONE"` | no |
| most\_disruptive\_allowed\_action | The most disruptive action to perform on the instance during an update. | string | `"REPLACE"` | no |
| names | Instance names. | list(string) | n/a | yes |
| project\_id | The GCP project ID | string | n/a | yes |
| region | Region where the instances should be created. | string | n/a | yes |
| stateful\_disks | Map of maps of stateful disks. | any | `<map>` | no |
| stateful\_metadata | Map of maps of stateful metadata. | any | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_names | Names of stateful instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
