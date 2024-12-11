# Upgrading to MIG v13.0

The v13.0 release of MIG is a backwards incompatible release. Now the `project_id` is required input variable. Earlier it was set to `null` by default. But the `terraform plan` would fail because `google_compute_zones` data block requires a non-null `project_id`.
Users might be bypassing this by setting project at provider level and not providing `project_id` for mig module.

## Migration Instructions

### Explicitly provide project_id as input to the MIG module

Users would need to provide project_id explicitly while using v13.0 of mig/mig_with_percent.

For mig,

```diff
module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 12.0"

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
  version = "~> 12.0"

+ project_id                        = var.project_id
  region                            = var.region
  target_size                       = 4
  hostname                          = "mig-with-percent-simple"
  instance_template_initial_version = module.preemptible_and_regular_instance_templates.regular_self_link
  instance_template_next_version    = module.preemptible_and_regular_instance_templates.preemptible_self_link
  next_version_percent              = 50
}
```
