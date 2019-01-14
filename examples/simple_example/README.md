# Simple Example

This example illustrates how to use the vm module.

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| credentials_path | The path to a Google Cloud Service Account credentials file | string | - | yes |
| project_id | The project ID to deploy to | string | - | yes |
| region | The region to deploy to | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| project_id |  |
| region |  |

[^]: (autogen_docs_end)

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure