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
[`roles/serviceusage.serviceUsageAdmin`](https://cloud.google.com/iam/docs/understanding-roles#service-usage-roles)

## Usage

```
terraform plan -var='project_id=<YOUR PROJECT ID>' -out=tfplan
terraform apply tfplan
```

[^]: (autogen_docs_start)

[^]: (autogen_docs_end)