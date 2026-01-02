# OS Login SSH Public Key Example

This example demonstrates how to use the OS Login module to manage SSH public keys for service accounts on Google Cloud Platform.

## Prerequisites

1. Enable the OS Login API:
   ```bash
   gcloud services enable oslogin.googleapis.com --project=YOUR_PROJECT_ID
   ```

2. Ensure your Terraform service account has the required permissions:
   - `roles/compute.osAdminLogin` or `roles/compute.osLogin`
   - `roles/iam.serviceAccountUser` (for the target service accounts)

3. Have an SSH public key ready (e.g., `~/.ssh/id_rsa.pub`)

## Usage

### Basic Example

To run this example, you need to execute:

```bash
terraform init
terraform plan -var="project_id=YOUR_PROJECT_ID" \
               -var="service_account_email=YOUR_SA@YOUR_PROJECT.iam.gserviceaccount.com"
terraform apply -var="project_id=YOUR_PROJECT_ID" \
                -var="service_account_email=YOUR_SA@YOUR_PROJECT.iam.gserviceaccount.com"
```

### Using terraform.tfvars

Create a `terraform.tfvars` file:

```hcl
project_id            = "my-project-id"
service_account_email = "my-service-account@my-project-id.iam.gserviceaccount.com"
ssh_public_key_path   = "~/.ssh/id_rsa.pub"
```

Then run:

```bash
terraform init
terraform plan
terraform apply
```

## Examples Included

This example demonstrates:

1. **Single SSH Key**: Associate one SSH key with a single service account
2. **Multiple Service Accounts**: Associate the same SSH key with multiple service accounts using `for_each`
3. **Expiring Key**: Add an SSH key with an expiration time

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| project_id | The project ID to deploy resources | string | yes |
| service_account_email | The service account email to associate SSH keys with | string | yes |
| ssh_public_key_path | Path to the SSH public key file | string | no (default: ~/.ssh/id_rsa.pub) |

## Outputs

| Name | Description |
|------|-------------|
| single_key_fingerprint | The fingerprint of the single SSH key |
| multiple_accounts_fingerprints | The fingerprints of SSH keys for multiple accounts |
| expiring_key_info | Information about the expiring SSH key |

## Testing the SSH Connection

After applying the Terraform configuration, you can test SSH connectivity to VMs with OS Login enabled:

```bash
# SSH to a VM using the service account
gcloud compute ssh VM_NAME \
  --zone=ZONE \
  --tunnel-through-iap \
  --impersonate-service-account=YOUR_SA@YOUR_PROJECT.iam.gserviceaccount.com
```

## Clean Up

To remove all resources created by this example:

```bash
terraform destroy -var="project_id=YOUR_PROJECT_ID" \
                  -var="service_account_email=YOUR_SA@YOUR_PROJECT.iam.gserviceaccount.com"
```
