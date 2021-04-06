# Compute Disk Snapshot

This module is used to create one resource policy for disk snapshots and attaching
persistent disks to the created snapshot policy. This module allows you to have
scheduled snapshots for persistent disks.

## Usage

See the [disk snapshot](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/examples/compute_instance/disk_snapshot) for a usage example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| disks | List of self\_links persistent disks to attach the snapshot policy to (ie. projects/project\_id/disks/diskname/zones/zone\_name) | `list(string)` | `[]` | no |
| module\_depends\_on | List of modules or resources this module depends on | `list(any)` | `[]` | no |
| name | Name of the resource policy to create | `string` | n/a | yes |
| project | The project ID where the resources will be created | `string` | n/a | yes |
| region | Region where resource policy resides | `string` | n/a | yes |
| snapshot\_properties | The properties of the schedule policy. For more details see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy#snapshot_properties | <pre>object(<br>    {<br>      guest_flush       = bool<br>      labels            = map(string)<br>      storage_locations = list(string)<br>    }<br>  )</pre> | `null` | no |
| snapshot\_retention\_policy | The retention policy to be applied to the schedule policy. For more details see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy#retention_policy | <pre>object(<br>    {<br>      max_retention_days    = number<br>      on_source_disk_delete = string<br>    }<br>  )</pre> | n/a | yes |
| snapshot\_schedule | The scheduled to be used by the snapshot policy. For more details see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy#schedule | <pre>object(<br>    {<br>      daily_schedule = object(<br>        {<br>          days_in_cycle = number<br>          start_time    = string<br>        }<br>      )<br>      hourly_schedule = object(<br>        {<br>          hours_in_cycle = number<br>          start_time     = string<br>        }<br>      )<br>      weekly_schedule = object(<br>        {<br>          day_of_weeks = set(object(<br>            {<br>              day        = string<br>              start_time = string<br>            }<br>          ))<br>        }<br>      )<br>    }<br>  )</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| attachments | Disk attachments to the resource policy |
| policy | Resource snapshot policy details |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
