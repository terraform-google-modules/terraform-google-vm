# Upgrading to v13.0

The v13.0 release of MIG and instance_template is a backwards incompatible release.

## `modules/mig` and `modules/mig_with_percent`

Now the `project_id` is required input variable. Earlier it was set to `null` by default. But the `terraform plan` would fail because `google_compute_zones` data block requires a non-null `project_id`.
Users might be bypassing this by setting project at provider level and not providing `project_id` for mig module.

## `modules/instance_template` and `modules/preemptible_and_regular_instance_templates`

* Now the `project_id` and `region` is required input variable. Earlier it was set to `null` by default.


## Migration Instructions

### Explicitly provide project_id as input to the MIG modules

Users would need to provide project_id explicitly while using v13.0 of mig/mig_with_percent.

For mig,

```diff
module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 13.0"

+ project_id        = var.project_id
  region            = var.region
  target_size       = var.target_size
  hostname          = "mig-simple"
  instance_template = module.instance_template.self_link
}
```

For mig_with_percent,

```diff
module "mig_with_percent" {
  source  = "terraform-google-modules/vm/google//modules/mig_with_percent"
  version = "~> 13.0"

+ project_id                        = var.project_id
  region                            = var.region
  target_size                       = 4
  hostname                          = "mig-with-percent-simple"
  instance_template_initial_version = module.preemptible_and_regular_instance_templates.regular_self_link
  instance_template_next_version    = module.preemptible_and_regular_instance_templates.preemptible_self_link
  next_version_percent              = 50
}
```

### Explicitly provide project_id/region as input to the instance_template modules

For instance_template,

```diff
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 13.0"

+ project_id                   = var.project_id
+ region                       = var.region
  subnetwork                   = var.subnetwork
  stack_type                   = "IPV4_ONLY"
  service_account              = var.service_account
  name_prefix                  = "simple"
  tags                         = var.tags
  labels                       = var.labels
  access_config                = [local.access_config]
  enable_nested_virtualization = var.enable_nested_virtualization
  threads_per_core             = var.threads_per_core
}
```

For preemptible_and_regular_instance_templates

```diff
module "preemptible_and_regular_instance_templates" {
  source  = "terraform-google-modules/vm/google//modules/preemptible_and_regular_instance_templates"
  version = "~> 13.0"

  subnetwork      = var.subnetwork
+ project_id      = var.project_id
+ region          = var.region
  service_account = var.service_account
  name_prefix     = "pvm-and-regular-simple"
  tags            = var.tags
  labels          = var.labels
}
```
