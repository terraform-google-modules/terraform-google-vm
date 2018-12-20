/**
* # terraform-gcp-umig

* This is a module to spin up N number of compute instances (with static IPs) with an unmanaged instance group, where N is the number of static IPs in the `instance_ips` input list.

* The GCP internal load balancer does not currently support certain use cases such as cross-region traffic or path-based routing. As a result, we are planning to use the existing F5 load balancer on-prem as a stop-gap solution. In order to configure the F5, we have to provide a list of static IPs. Instances in managed instance groups cannot have static internal IPs, so we are left with plain old compute instances with reserved IPs in an unmanaged instance group.

* This module follows the same pattern of using the metadata server to pass variables and scripts as the other "fe" modules. However, because the scripts and templates in `files` and `templates` are just copied over, be aware that any changes to these files will need to be propagated manually to the other module, and vice versa.

* ## Example usage

* See the living [barebones](examples/barebones-test-fixture) test fixture example for usage.

* ## Known Issues

* 1. When using this module and trying to do targetted plan/apply, e.g. `terraform plan -target=module.frontend.module.internal_umigs.google_compute_instance.compute_instance[0]`, you may see an error similiar to the follwing:

* ```
* Error: Error refreshing state: 1 error(s) occurred:
* * module.frontend.module.internal_umigs.output.umigs: cannot parse "${local.instance_group_count_with_named_ports}" as an integer
* ```

* The problem is described in more detail in this [Github issue](https://github.com/hashicorp/terraform/issues/17462) - it has something to do with how targetted plan/apply works it won't be fixed until Terraform 0.12. Until then, the only known workaround is to avoid plumbing the `umigs` output from the module through your middle-tier Terraform layers. You can still use the `umigs` output as long as you are refering to it directly. For example, you have an internal "frontend" module which wraps the UMIG and ILB modules. You can use `${module.my_umig.umigs}` as an input to the ILB module. However, you won't be able to define `${module.my_umig.umigs}` as an output of your frontend module; this would trigger the error above.

* ## Testing

* Tests for this module work but only when the call and references to the stdlib module have been
* removed. The test fixture and tests that can be run through Docker with the goal
* of running these through CI/CD. To get started testing locally:

* 1. Ensure a GCP credentials file sits at the repo root named `tk-tester.json`. This credential file should align with the `PROJECT_NAME` you'll pass to Docker.
* 2. Install and run the [Docker CE daemon](https://www.docker.com/community-edition).
* 3. Build the Docer image and run all tests substituting the PROJECT_NAME for your sandbox:

*     ```bash
*     docker build . -t ubuntu-test-kitchen-terraform --build-arg PROJECT_NAME=sandbox-bjacob
*     ```

* 4. The above command runs tests end-to-end using `bundle exec kitchen test --destroy always` as included in the Dockerfile. If that fails, you'll need to iterate over test and fixture code. Login and re-converge with the following:

*     ```bash
*     # using your sandbox project name as PROJECT_NAME
*     docker run -it -v $PWD:/root/live_workspace -e "PROJECT_NAME=sandbox-bjacob" -w /root/live_workspace ubuntu-test-kitchen-terraform
*     # while logged into the Docker container, run through the create, converge, verify cycle keeping resources alive when finished. Run this as many times as needed:
*     tf_test
*     ```

* Your repo root is now mounted in the Docker container so you can edit any
* tests or fixture code on your workstation and rerun the `converge` command above
* to retry. When finished, spin down your GCP resources within the same container with:

* ```bash
* # also within the container
* tf_destroy
* ```

* If you've created several images, clean your workstaion using:

* ```bash
* docker system prune --volumes -f
* ```

* ## Doc generation

* Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs).
* Generate them like so:

* ```bash
* go get github.com/segmentio/terraform-docs
* terraform-docs md ./ | cat -s | tail -r | tail -n +2 | tail -r > README.md
* ```
**/

