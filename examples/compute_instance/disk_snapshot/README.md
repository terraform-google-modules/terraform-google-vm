# disk-snapshot

This is a simple example of how to use the compute_disk_snapshot module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_disks | List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name | <pre>list(object({<br>    auto_delete  = bool<br>    boot         = bool<br>    disk_size_gb = number<br>    disk_type    = string<br>  }))</pre> | <pre>[<br>  {<br>    "auto_delete": true,<br>    "boot": false,<br>    "disk_size_gb": 20,<br>    "disk_type": "pd-standard"<br>  },<br>  {<br>    "auto_delete": true,<br>    "boot": false,<br>    "disk_size_gb": 30,<br>    "disk_type": "pd-standard"<br>  }<br>]</pre> | no |
| project\_id | The GCP project to use for integration tests | `string` | n/a | yes |
| region | The GCP region to create and test resources in | `string` | `"us-central1"` | no |
| subnetwork | The subnetwork selflink to host the compute instances in | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| disk\_snapshots | List of disks snapshots and the snapshot policy |
| instances\_self\_links | List of self-links for compute instances |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
