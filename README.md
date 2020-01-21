# terraform-google-vm

This is a collection of opinionated submodules that can be used as building blocks to provision VMs in GCP:

* [Instance template](modules/instance_template)
* [Managed instance group](modules/mig)
* [Unmanaged instance group](modules/umig)

## Compatibility

 This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html)
  and need a Terraform 0.11.x-compatible version of this module, the last released version intended for
  Terraform 0.11.x is [0.2.0](https://registry.terraform.io/modules/terraform-google-modules/vm/google/0.2.0).


## Examples

Examples of how to use these modules can be found in the [examples](examples) folder.

## Project APIs

The following APIs must be enabled on your project:
- `compute.googleapis.com`
- `iam.googleapis.com`

See also the [project_services](modules/project_services) module (optional).

## Notes

`distribution_policy_zones` cannot be changed during use.
If you have changed them yourself or used to have a default value, then you'll have to force recreate a MIG group yourself.

## Test Configuration

1. Create a `terraform.tfvars` file, using `terraform.tfvars.example` as an example

```shell
cp test/fixtures/shared/terraform.tfvars.example test/fixtures/shared/terraform.tfvars
```

The `terraform.tfvars` in each fixture directory is already symlinked to this one shared file.

2. Populate the variables with values appropriate for your test environment (i.e. `project_id`, `service_account.email`)
3. Download a Service Account key with the necessary [permissions](#permissions) and put it in the module's root directory with the name credentials.json.

## Running Tests

From the root of the module, run

```
make test_integration_docker
```

to build the container and run through all the test suites. Note that this will take some time (> 20 minutes).

You can also run each test case individually and interactively in the Docker container:

```
make docker_run
```

The root directory of the module will be mounted to `/cft/workdir` in the container. For example, to run the `mig-autoscaler` test suite:

```
bundle exec kitchen test mig-autosaler
```

or

```
bundle exec kitchen create mig-autoscaler
bundle exec kitchen converge mig-autoscaler
bundle exec kitchen verify mig-autoscaler
bundle exec kitchen destroy mig-autoscaler
```

## Permissions

The service account used to execute tests for this module should have the following roles:
- [`roles/compute.admin`](https://cloud.google.com/iam/docs/understanding-roles#compute-engine-roles)
- [`roles/iam.serviceAccountUser`](https://cloud.google.com/iam/docs/understanding-roles#service-accounts-roles)
