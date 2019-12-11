{% if mig %}
# Managed Instance Group (MIG)

This module is used to create a [google_compute_region_instance_group_manager](https://www.terraform.io/docs/providers/google/r/compute_region_instance_group_manager.html),
and optionally, an autoscaler and healthchecks.

{% else %}
# Managed Instance Group (MIG) with percent

This module allows you to set the percentage ratio of second version of instance template on Managed Instance Group.

{% endif %}
## Usage

See the [simple example](../../examples/{{ module_name }}/simple) for a usage example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
