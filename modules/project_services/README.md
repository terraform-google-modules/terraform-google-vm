# project_services

This optional module is used to enable project APIs in your test project. The
APIs that need to be enabled for the instance_template, MIG, and UMIG modules to
function are:
- `compute.googleapis.com`
- `iam.googleapis.com`

Ideally, this should be done as part of project creation (e.g. via
[Project Factory](https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/variables.tf#L64-L68)). However, you can run this standalone
provided the [prerequisites](#prerequisites) below are satisfied.

## Prerequisites

1. Enable Service Usage API: `serviceusage.googleapis.com`
2. Service account used to run Terraform has permissions to manage project APIs: 
[`roles/serviceusage.serviceUsageAdmin`](https://cloud.google.com/iam/docs/understanding-roles#service-usage-roles) or `Owner`

## Usage

```
terraform plan -var='project_id=<YOUR PROJECT ID>' -out=tfplan
terraform apply tfplan
```

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| activate\_apis | The list of apis to activate within the project | list | `<list>` | no |
| disable\_services\_on\_destroy | Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy | string | `"true"` | no |
| enable\_apis | Whether to actually enable the APIs. If false, this module is a no-op. | string | `"true"` | no |
| project\_id | The GCP project you want to enable APIs on | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | The GCP project you want to enable APIs on |

[^]: (autogen_docs_end)