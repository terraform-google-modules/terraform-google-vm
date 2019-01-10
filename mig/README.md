# Managed Instance Group (MIG)


## Example usage

See the [simple](examples/mig/simple) test fixture example for usage.

## Testing


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| hostname | Hostname of instances | string | `` | no |
| image_family | Disk image family | string | `` | no |
| image_name | Disk image name | string | `` | no |
| img_src_project | Project holding images | string | `` | no |
| instance_ips | List of static IPs for VM instances | list | `<list>` | no |
| labels | Labels to apply to all instances | map | `<map>` | no |
| machine_type | Machine Type | string | `n1-standard-4` | no |
| metadata | Metadata for each instance, provided as a map | map | `<map>` | no |
| named_port | Named name and named port | list | `<list>` | no |
| num_instances | Number of instances to create | string | `1` | no |
| project | Project ID | string | - | yes |
| region | GCP region | string | `us-west1` | no |
| root_volume_size_gb | Root volume size in GB | string | `40` | no |
| service_account_email | Service account email | string | `` | no |
| service_account_scopes | Service account scopes | list | `<list>` | no |
| subnetwork | Subnet to deploy to | string | - | yes |
| tags | Network tags to apply to all instances | string | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| instances_self_links | List of self_links for compute instances |
| umig_self_links | List of self_links for unmanaged instance groups |
