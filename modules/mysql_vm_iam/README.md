## Description
This module allows you to assign IAP access to MySQL instances based on Google Workspace group membership.

Once IAP access is granted, users can connect using the command syntax below:

```shell 
$(gcloud info --format="value(basic.python_location)") -m pip install numpy
export CLOUDSDK_PYTHON_SITEPACKAGES=1

then

gcloud compute start-iap-tunnel \
    --project="${GCP_PROJECT}" \
    --zone="${INSTANCE_ZONE}" \
    "${INSTANCE_NAME}" 3306 \
    --local-host-port=localhost:3306

This also requires having a user on MySQL that can connect from
'35.%' IP (IAP's IP address as set in the firewall)
```
## Providers
| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_dba_email"></a> [iam\_dba\_email](#input\_iam\_dba\_email) | IAM format of the DBA Group Email in Gsuite | `string` | n/a | yes |
| <a name="input_iap_accessor_iam"></a> [iap\_accessor\_iam](#input\_iap\_accessor\_iam) | IAM Email of the group that can access the instances via IAP | `string` | `null` | no |
| <a name="input_instance_hostnames"></a> [instance\_hostnames](#input\_instance\_hostnames) | List of hostnames | `list(string)` | n/a | yes |
| <a name="input_instance_ips"></a> [instance\_ips](#input\_instance\_ips) | List of IP addresses | `list(string)` | n/a | yes |
| <a name="input_instance_zones"></a> [instance\_zones](#input\_instance\_zones) | List of zones for each hostname | `list(string)` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID for the instances. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | IDs of Secrets Manager secrets that contain backup user credentials | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account to be used for taking snapshots | `string` | n/a | yes |