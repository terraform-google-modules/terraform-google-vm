# Changelog

All notable changes to this project will be documented in this file. See [conventional-commits](https://www.conventionalcommits.org/) for commit guidelines.

## [12.1.1](https://github.com/terraform-google-modules/terraform-google-vm/compare/v12.1.0...v12.1.1) (2024-11-27)


### Bug Fixes

* Update variable's order in variables.tf and update display met… ([#444](https://github.com/terraform-google-modules/terraform-google-vm/issues/444)) ([99a2395](https://github.com/terraform-google-modules/terraform-google-vm/commit/99a2395d95591cb8191086f23399c69ca2cbd05b))

## [12.1.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v12.0.0...v12.1.0) (2024-10-22)


### Features

* add confidential computing example for intel arch ([#435](https://github.com/terraform-google-modules/terraform-google-vm/issues/435)) ([cf84229](https://github.com/terraform-google-modules/terraform-google-vm/commit/cf84229c7e1fb5e4233d0d24d34c17732bae0e4f))
* add org policies to confidential computing example ([#427](https://github.com/terraform-google-modules/terraform-google-vm/issues/427)) ([c5788d0](https://github.com/terraform-google-modules/terraform-google-vm/commit/c5788d034414e4e3821db1918e40201066194017))

## [12.0.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v11.1.0...v12.0.0) (2024-09-09)


### ⚠ BREAKING CHANGES

* **TPG>=5.36:** add confidential_instance_type to instance_template module ([#416](https://github.com/terraform-google-modules/terraform-google-vm/issues/416))
* **variables:** allow optional attributes for update_policy object ([#407](https://github.com/terraform-google-modules/terraform-google-vm/issues/407))

### Features

* add confidential computing example ([#421](https://github.com/terraform-google-modules/terraform-google-vm/issues/421)) ([ddb6985](https://github.com/terraform-google-modules/terraform-google-vm/commit/ddb698562ebd983dc2fa5b05124aeeced5b3d5c5))
* add disk resource policies ([#412](https://github.com/terraform-google-modules/terraform-google-vm/issues/412)) ([c5409d2](https://github.com/terraform-google-modules/terraform-google-vm/commit/c5409d2a4c261cb10a11042b47bd6602411d85d7))
* **deps:** Update Terraform Google Provider to v6 (major) ([#425](https://github.com/terraform-google-modules/terraform-google-vm/issues/425)) ([b9b818e](https://github.com/terraform-google-modules/terraform-google-vm/commit/b9b818ec5b9e62fc93640bd9aa1dc918a67e862e))
* **instance_template:** supporting template and generated instance description ([#388](https://github.com/terraform-google-modules/terraform-google-vm/issues/388)) ([7ed3780](https://github.com/terraform-google-modules/terraform-google-vm/commit/7ed37800056e7c53313803fb1d926c37eee232bf))
* **TPG>=5.36:** add confidential_instance_type to instance_template module ([#416](https://github.com/terraform-google-modules/terraform-google-vm/issues/416)) ([1073c39](https://github.com/terraform-google-modules/terraform-google-vm/commit/1073c3905dec53b33c6b01f79f664ad0dedccfd4))
* Update instance template var.additional_disks to include all fields being passed to API ([#399](https://github.com/terraform-google-modules/terraform-google-vm/issues/399)) ([73dc845](https://github.com/terraform-google-modules/terraform-google-vm/commit/73dc8459301886207e242fb755b7e31ba46c28e0))


### Bug Fixes

* For error_message of variable - maintenance_interval ([#411](https://github.com/terraform-google-modules/terraform-google-vm/issues/411)) ([40502fd](https://github.com/terraform-google-modules/terraform-google-vm/commit/40502fd7623b069331b0f55aa72d512f2dcf063e))
* mark instances_details as sensitive ([#389](https://github.com/terraform-google-modules/terraform-google-vm/issues/389)) ([c923bfe](https://github.com/terraform-google-modules/terraform-google-vm/commit/c923bfe05d93f9e63465458b6cbca8b2c33d0a0f))
* **variables:** allow optional attributes for update_policy object ([#407](https://github.com/terraform-google-modules/terraform-google-vm/issues/407)) ([6769c24](https://github.com/terraform-google-modules/terraform-google-vm/commit/6769c24bc4b7b070bab8dee2c9a33fff1e0b9eb4))

## [11.1.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v11.0.0...v11.1.0) (2024-03-11)


### Features

* mig labels & most disruptive update policy action update ([#381](https://github.com/terraform-google-modules/terraform-google-vm/issues/381)) ([61ba9bf](https://github.com/terraform-google-modules/terraform-google-vm/commit/61ba9bf6e18c71560e657a19b2bd256361844049))

## [11.0.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v10.1.1...v11.0.0) (2024-02-20)


### ⚠ BREAKING CHANGES

* **TPG>=5.5:** support setting maintenance_interval in instance_template ([#357](https://github.com/terraform-google-modules/terraform-google-vm/issues/357))

### Features

* change default distro image from CentOS 7 to Rocky Linux 9 ([#375](https://github.com/terraform-google-modules/terraform-google-vm/issues/375)) ([94c9c48](https://github.com/terraform-google-modules/terraform-google-vm/commit/94c9c4823343712416375c0c5614f8f17a9708e2))
* **TPG>=5.5:** support setting maintenance_interval in instance_template ([#357](https://github.com/terraform-google-modules/terraform-google-vm/issues/357)) ([c7b47bc](https://github.com/terraform-google-modules/terraform-google-vm/commit/c7b47bc23fe86100acfd59e53af02fd211140580))


### Bug Fixes

* **deps:** Update module github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test to v0.12.0 ([#380](https://github.com/terraform-google-modules/terraform-google-vm/issues/380)) ([74c9d43](https://github.com/terraform-google-modules/terraform-google-vm/commit/74c9d43cc2948053e5dd3bd025ae1b0c4a698429))

## [10.1.1](https://github.com/terraform-google-modules/terraform-google-vm/compare/v10.1.0...v10.1.1) (2023-10-27)


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#350](https://github.com/terraform-google-modules/terraform-google-vm/issues/350)) ([677b27b](https://github.com/terraform-google-modules/terraform-google-vm/commit/677b27b912d4ee4fcc59a4510f35c5f917c29fe1))

## [10.1.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v10.0.0...v10.1.0) (2023-09-29)


### Features

* add var.resource_policies to instance_template ([#317](https://github.com/terraform-google-modules/terraform-google-vm/issues/317)) ([d959936](https://github.com/terraform-google-modules/terraform-google-vm/commit/d959936f446b2e8dee9f0c2f05a349755bc37373))
* support source_snapshot for additional_disks ([#341](https://github.com/terraform-google-modules/terraform-google-vm/issues/341)) ([76e9c19](https://github.com/terraform-google-modules/terraform-google-vm/commit/76e9c192869c444b84a9e6468e711e948a9219be))


### Bug Fixes

* enables metadata autogen ([#337](https://github.com/terraform-google-modules/terraform-google-vm/issues/337)) ([16cd050](https://github.com/terraform-google-modules/terraform-google-vm/commit/16cd050ba188cc66f65fd987ddc4178c8721fc91))

## [10.0.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v9.0.0...v10.0.0) (2023-09-21)


### ⚠ BREAKING CHANGES

* add instances_details sensitive output ([#308](https://github.com/terraform-google-modules/terraform-google-vm/issues/308))
* allow to override umig availability zones ([#329](https://github.com/terraform-google-modules/terraform-google-vm/issues/329))
* enable fuller networking features in instance_template module ([#330](https://github.com/terraform-google-modules/terraform-google-vm/issues/330))

### Features

* Add resource_manager_tags to module and use it on google_compute_instance_from_template. ([#344](https://github.com/terraform-google-modules/terraform-google-vm/issues/344)) ([652a98e](https://github.com/terraform-google-modules/terraform-google-vm/commit/652a98e7561fdd20ce2e676cc6668572078aac5b))
* allow to override umig availability zones ([#329](https://github.com/terraform-google-modules/terraform-google-vm/issues/329)) ([4dc9d57](https://github.com/terraform-google-modules/terraform-google-vm/commit/4dc9d57cb81128b9f487d7f203831a8d4c6ecfd0))
* enable fuller networking features in instance_template module ([#330](https://github.com/terraform-google-modules/terraform-google-vm/issues/330)) ([7917ba6](https://github.com/terraform-google-modules/terraform-google-vm/commit/7917ba6924e2bd8a04b8e25236ec451e5ea1923c))
* support self_link_unique output of instance template resource ([#347](https://github.com/terraform-google-modules/terraform-google-vm/issues/347)) ([fab60cd](https://github.com/terraform-google-modules/terraform-google-vm/commit/fab60cd66f1abed795acf4bfdf0098641bb510c1))
* support setting instance_termination_action for Spot VMs ([#346](https://github.com/terraform-google-modules/terraform-google-vm/issues/346)) ([6f74715](https://github.com/terraform-google-modules/terraform-google-vm/commit/6f7471557f2beea94b91f81168aba50878737aa5))
* support setting nic_type of primary network interface ([#334](https://github.com/terraform-google-modules/terraform-google-vm/issues/334)) ([f067e54](https://github.com/terraform-google-modules/terraform-google-vm/commit/f067e54fd1006e0623677d60686fd95d8d625fd0))


### Bug Fixes

* add instances_details sensitive output ([#308](https://github.com/terraform-google-modules/terraform-google-vm/issues/308)) ([85fd51e](https://github.com/terraform-google-modules/terraform-google-vm/commit/85fd51e618211a2333e3fb3b6a8d2addf74e2ad0))
* minor lint fixes ([#333](https://github.com/terraform-google-modules/terraform-google-vm/issues/333)) ([6750fec](https://github.com/terraform-google-modules/terraform-google-vm/commit/6750fec417e1a3db92312e1bb833039df6328a19))
* remove unnecessary validation block ([#335](https://github.com/terraform-google-modules/terraform-google-vm/issues/335)) ([84fbd1f](https://github.com/terraform-google-modules/terraform-google-vm/commit/84fbd1fa0df737accffd61d7fbbe8febee18b56e))

## [9.0.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v8.0.1...v9.0.0) (2023-08-22)


### ⚠ BREAKING CHANGES

* allow to override compute instance labels ([#311](https://github.com/terraform-google-modules/terraform-google-vm/issues/311))
* autoscaler supporting stateful ips ([#297](https://github.com/terraform-google-modules/terraform-google-vm/issues/297))

### Features

* add spot instances ([#294](https://github.com/terraform-google-modules/terraform-google-vm/issues/294)) ([99efc45](https://github.com/terraform-google-modules/terraform-google-vm/commit/99efc456097df4f28b8a78ab72ba325d0617d20c))
* allow to override compute instance labels ([#311](https://github.com/terraform-google-modules/terraform-google-vm/issues/311)) ([aea74d1](https://github.com/terraform-google-modules/terraform-google-vm/commit/aea74d101b7219769bbb0d1559d190f3b7f08182))
* autoscaler supporting stateful ips ([#297](https://github.com/terraform-google-modules/terraform-google-vm/issues/297)) ([5d13e8b](https://github.com/terraform-google-modules/terraform-google-vm/commit/5d13e8b876fb73691dedfe80e32ee8280f2a98b4))
* expose distribution_policy_target_shape setting for MIGs  ([#327](https://github.com/terraform-google-modules/terraform-google-vm/issues/327)) ([1c8f775](https://github.com/terraform-google-modules/terraform-google-vm/commit/1c8f7759262c0a24f83268fcb7561bb7e01e7d8b))

## [8.0.1](https://github.com/terraform-google-modules/terraform-google-vm/compare/v8.0.0...v8.0.1) (2023-04-06)


### Bug Fixes

* change stack_type for better upgrade compat ([#293](https://github.com/terraform-google-modules/terraform-google-vm/issues/293)) ([d15a307](https://github.com/terraform-google-modules/terraform-google-vm/commit/d15a3077715146a49b9624a817234fd9d06b103d))

## [8.0.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.9.0...v8.0.0) (2022-12-29)


### ⚠ BREAKING CHANGES

* Add support of "ipv6_access_config" param for compute instance and instance template ([#284](https://github.com/terraform-google-modules/terraform-google-vm/issues/284))
* support health check logging ([#283](https://github.com/terraform-google-modules/terraform-google-vm/issues/283))
* Allow setting predictive method for CPU utilization scaling ([#255](https://github.com/terraform-google-modules/terraform-google-vm/issues/255))

### Features

* Add support of "ipv6_access_config" param for compute instance and instance template ([#284](https://github.com/terraform-google-modules/terraform-google-vm/issues/284)) ([fc40db1](https://github.com/terraform-google-modules/terraform-google-vm/commit/fc40db15806d7882a7d67577cca2ebebb2185aa3))
* Allow setting predictive method for CPU utilization scaling ([#255](https://github.com/terraform-google-modules/terraform-google-vm/issues/255)) ([28c77b5](https://github.com/terraform-google-modules/terraform-google-vm/commit/28c77b553d1f4462ef21fe55f4e4bfb26eb6d892))
* support health check logging ([#283](https://github.com/terraform-google-modules/terraform-google-vm/issues/283)) ([2b31071](https://github.com/terraform-google-modules/terraform-google-vm/commit/2b31071cb3dacf2e5b68e2a71b0499ce87880423))


### Bug Fixes

* fixes lint issues and generates metadata ([#288](https://github.com/terraform-google-modules/terraform-google-vm/issues/288)) ([b071db1](https://github.com/terraform-google-modules/terraform-google-vm/commit/b071db16c8de00f43c144cd9f85703de2a228f40))

## [7.9.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.8.0...v7.9.0) (2022-09-20)


### Features

* Add support for resource_policies ([#260](https://github.com/terraform-google-modules/terraform-google-vm/issues/260)) ([c382631](https://github.com/terraform-google-modules/terraform-google-vm/commit/c382631f0870204b6db1b6b30f6484fe2bb0fcac))


### Bug Fixes

* allow null service_account ([#262](https://github.com/terraform-google-modules/terraform-google-vm/issues/262)) ([c95056c](https://github.com/terraform-google-modules/terraform-google-vm/commit/c95056c5236d7faba1497e1eb54e3938a0c35ba1))

## [7.8.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.7.0...v7.8.0) (2022-06-03)


### Features

* **mig:** Add option to configure autoscaling schedules ([#247](https://github.com/terraform-google-modules/terraform-google-vm/issues/247)) ([0269e71](https://github.com/terraform-google-modules/terraform-google-vm/commit/0269e71eeaff5dbfdaaf2e83c74c8a3273122a4e))

## [7.7.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.6.0...v7.7.0) (2022-04-12)


### Features

* Add IP Alias Range feature on compute instance module ([#233](https://github.com/terraform-google-modules/terraform-google-vm/issues/233)) ([3601c5b](https://github.com/terraform-google-modules/terraform-google-vm/commit/3601c5b8d91e6497efcc97789f98fbee17c9f2a3))


### Bug Fixes

* alias-ip dynamic block ([#242](https://github.com/terraform-google-modules/terraform-google-vm/issues/242)) ([a5b6a81](https://github.com/terraform-google-modules/terraform-google-vm/commit/a5b6a814fd051dd8c10853ab5427091ab6fc4d67))

## [7.6.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.5.0...v7.6.0) (2022-03-02)


### Features

* Add advanced machine feature options for enabling virtualization and setting threads per core ([#236](https://github.com/terraform-google-modules/terraform-google-vm/issues/236)) ([4f21330](https://github.com/terraform-google-modules/terraform-google-vm/commit/4f21330db1c5949a2e203376a1ed5a57256699f2))


### Bug Fixes

* Use network settings from template when no specific override is in place ([#239](https://github.com/terraform-google-modules/terraform-google-vm/issues/239)) ([b48928a](https://github.com/terraform-google-modules/terraform-google-vm/commit/b48928abdca289f927fa0e5ab0fc6d8401694f18))

## [7.5.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.4.0...v7.5.0) (2022-02-01)


### Features

* [compute_instance] Add deletion_protection variable ([#231](https://github.com/terraform-google-modules/terraform-google-vm/issues/231)) ([de34522](https://github.com/terraform-google-modules/terraform-google-vm/commit/de345228ce379b6066bb27ba438dd09313dc2627))

## [7.4.0](https://github.com/terraform-google-modules/terraform-google-vm/compare/v7.3.0...v7.4.0) (2022-01-19)


### Features

* [mig] Add "autoscaling_mode" variable ([#224](https://github.com/terraform-google-modules/terraform-google-vm/issues/224)) ([019e3a4](https://github.com/terraform-google-modules/terraform-google-vm/commit/019e3a41e1828abd6478fe1022c576573e3d6bc9))
* add suffix separator variable ([#218](https://github.com/terraform-google-modules/terraform-google-vm/issues/218)) ([d4e0e87](https://github.com/terraform-google-modules/terraform-google-vm/commit/d4e0e87129804b6d1d9eb43ef7c14728be659ad2))

## [7.3.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v7.2.0...v7.3.0) (2021-11-24)


### Features

* update TPG version constraints to allow 4.0 ([#215](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/215)) ([af7347b](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/af7347bab9de2e2ba2a8269cedde5e0ec5cc6d24))

## [7.2.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v7.1.0...v7.2.0) (2021-10-13)


### Features

* Alias IP Ranges ([#207](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/207)) ([0463fc9](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/0463fc935e2af8f97da25d2ce0bf18481e0035ad))

## [7.1.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v7.0.0...v7.1.0) (2021-08-02)


### Features

* add support for adding additional network interfaces ([#199](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/199)) ([ea44b89](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/ea44b89097d904746e15e1c2df0f52afa6a1f8a0))

## [7.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.6.0...v7.0.0) (2021-07-26)


### ⚠ BREAKING CHANGES

* `update_policy` must now include `replacement_method`.

### Features

* Adds replacement_method key to update_policy input to support Stateful MIG ([#189](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/189)) ([22843de](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/22843deb3bd1ecabb3cf6d368cb6382581e75dbc))


### Bug Fixes

* Remove data sources for instance source_image ([#190](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/190)) ([87c753f](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/87c753f58b09b2144a6a86546d58792de0d61196))
* revert change related to sensitive field bug in TF 0.15.0 ([#193](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/193)) ([f2d4921](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/f2d49212b18ffd9adfb2fa09063c486ee9c46093))

## [6.6.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.5.0...v6.6.0) (2021-06-14)


### Features

* Support setting var.disk_encryption_key for instance templates to enable encryption on all disks ([#181](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/181)) ([227ae1a](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/227ae1a2bdf43795c21f39fdcacc6298f9f04b74))

## [6.5.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.4.0...v6.5.0) (2021-05-26)


### Features

* **compute_instance:** added a variable to add/remove the hostname suffix for compute instance submodule ([#177](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/177)) ([07970f9](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/07970f915e6f068cc6ed8d7ab90cd4cd9bcaf74f))

## [6.4.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.3.0...v6.4.0) (2021-04-28)


### Features

* Add HTTPS health check support and use empty variables to indicate default names ([#170](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/170)) ([5ca905b](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/5ca905b54e22fedcf366627e5b90e3e4928fc25b))
* Add support for configuring autoscaler scale_in on MIGs ([#166](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/166)) ([5c0f061](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/5c0f061483f74031ce82a7c07d73ad9dd4a319f0))
* Adds labels to boot and additional disks ([#168](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/168)) ([9e930ce](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/9e930cee939e8573a9114bcd379dc16f72a21e72))


### Bug Fixes

* add sensitive setting for instances_details output ([#164](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/164)) ([5837759](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/5837759ae3d721078f575092a509aba25c00136d))

## [6.3.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.2.0...v6.3.0) (2021-04-16)


### Features

* Add confidential compute flags ([#131](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/131)) ([615c8bc](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/615c8bce7e9ceb9e0ab6eca7f1e32ae615c7ab12))
* Add min_cpu_platform variable support ([#161](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/161)) ([49829e8](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/49829e88c6ffa546725dd70cd63513f48a166f4a))
* Add option to specify zone in compute_instance ([#162](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/162)) ([e07828d](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/e07828d492ea6960ffa0c54445ad70d80441451e))
* Add support for guest_accelerator for the instance_template module ([#160](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/160)) ([a535e13](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/a535e131a8611ac7fe9ff409496c5c9d25865c6e))

## [6.2.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.1.0...v6.2.0) (2021-03-15)


### Features

* Add support for local-ssd disks ([#150](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/150)) ([d1ca163](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/d1ca163db77c56e0d86f676ea277f61af53beb72))


### Bug Fixes

* Change GCE image project as "gce-uefi-images" is being deprecated. ([#148](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/148)) ([04ac846](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/04ac846d8e29a662ee1467244ac30ecdc1ab6e50))

## [6.1.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v6.0.0...v6.1.0) (2021-02-22)


### Features

* Add module for creating scheduled snapshots for persistent disk ([#139](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/139)) ([cedac01](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/cedac012914e01b2664f567250b80d7aaf32c77e))
* Allow IP assignment in instance templates ([#118](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/118)) ([a53e140](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/a53e14011ce200b6d8b277838ff960dfebcc6db0))
* Allow overriding MIG name ([#142](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/142)) ([75a8baa](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/75a8baae3cd8a98517e08aaaf2169e29d8856959))


### Bug Fixes

* Add support for disk_name and device_name on additional_disks  ([#132](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/132)) ([a89a025](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/a89a0253591a412dd900499f79086f7b24e7acc6))
* disk snapshot working example ([#145](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/145)) ([698d865](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/698d8650d6a3acfd3647926f005876e06a9addc6))

## [6.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v5.1.0...v6.0.0) (2020-12-08)


### ⚠ BREAKING CHANGES

* Minimum Terraform version increased to 0.13.
* Update default source image and family to latest CentOS 7 (#126)

### Features

* add TF 0.13 constraint and module attribution ([#128](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/128)) ([d042aae](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/d042aae0ab50fbbe763ff551f3daa80aa8f1b551))
* adds an output for the health check self_links to be consumed by load balancer resources outside this module ([#119](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/119)) ([ae4d777](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/ae4d7777958fe4238d96191a3aa7c7deab996fd1))
* Update default source image and family to latest CentOS 7 ([#126](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/126)) ([6310016](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/63100169ebecea163f3965f4be3df8b600af047d))

## [5.1.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v5.0.0...v5.1.0) (2020-10-07)


### Features

* Added instance_group_manager output ([#105](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/105)) ([e8a174a](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/e8a174aa899f9ade792d1576689603eab6ca774e))

## [5.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v4.0.0...v5.0.0) (2020-09-15)


### ⚠ BREAKING CHANGES

* **UMIG:** var.access_config has been changed to a 2D array, with a separate element for each VM.

### Bug Fixes

* **UMIG:** access_config should be 2D array ([#111](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/111)) ([69f7520](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/69f752033453ceb2ee50a8d5614112ce96b60650))
* relax version constraints to enable terraform 0.13.x compatibility ([#108](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/108)) ([6fb2b42](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/6fb2b42bd96f90d3c2baffd511cb58200fbc074c))
* Terraform version upgrade for compute_instance module from 0.12.6 to 0.12.7 ([#103](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/103)) ([7a21e78](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/7a21e788f6ded801be8d3354bfd31934aca5b7fb))

## [4.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v3.0.0...v4.0.0) (2020-06-23)


### ⚠ BREAKING CHANGES

* instance_redistribution_type must now be specified for update policies.

### Features

* Add stateful disk support ([#90](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/90)) ([645e845](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/645e8453e945fe6f7b1c5cccd7ad557f5355cc10))
* Add wait_for_instances and configurable timeout support for mig ([#96](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/96)) ([10a23b7](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/10a23b70250bd26ed9820184b535e4ce99d24ec7))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v2.1.0...v3.0.0) (2020-05-27)


### ⚠ BREAKING CHANGES

* The preemptible_and_regular_instance_templates modules have had name_prefixes renamed, forcing instances to be recreated.

### Features

* Add support for assigning public IPs directly to instances. ([#83](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/83)) ([dde01ff](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/dde01ff376a8e58b4a365724cb4531a4e24435a5))


### Bug Fixes

* Correct names for instances in preemptible and regular instance module ([#81](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/81)) ([5a6ec12](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/5a6ec12c3d26c88e45fe4b1a1d919562b4995f24))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v2.0.0...v2.1.0) (2020-03-05)


### Features

* Allow the use of Google provider v3.x ([#78](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/78)) ([eea5267](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/eea52678b28c66d44c9cfe94a39b47fc6c496641))


### Bug Fixes

* Set target_size to null when autoscaling is enabled in MIG ([#65](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/65)) ([dd71466](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/dd7146642a740e779882e97725e551725ea6a04b)), closes [#64](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/64)

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v1.4.1...v2.0.0) (2020-01-31)


### ⚠ BREAKING CHANGES

* Health check variables and resources were reorganized in this backwards-incompatible release. See the [upgrade guide](./docs/upgrading_to_mig_v2.0.md) for details.

### Features

* Change the readme formatting ([f2e87b3](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/f2e87b3912e0095fde909cb5e0e1b4706d315edb))
* Fix healthchecks inconsistency. ([#56](https://www.github.com/terraform-google-modules/terraform-google-vm/issues/56)) ([5926dfc](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/5926dfce9d38c154092132666919c539cad48f6c))

### [1.4.1](https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.4.0...v1.4.1) (2020-01-21)


### Bug Fixes

* derive project id for instance from instance template ([#63](https://github.com/terraform-google-modules/terraform-google-vm/issues/63)) ([3e2c8cd](https://github.com/terraform-google-modules/terraform-google-vm/commit/3e2c8cdeb2d0e6f1fe53bc2d0a9369c9dc59f013))

### Changed

- Replace health check related variables with a single object type parameter called `health_check` on the `mig` and
  `mig_with_percent` submodules. [#56]

## [1.4.0] - 2020-01-08

### Added

- `access_config` variable on the `umig` submodule. [#57]

### Changed

- The required Terraform provider versions are enforced. [#52]

## [1.3.0] - 2019-12-09

### Added

- Output for `tags` from `instance_template` [#33]

## [1.2.0] - 2019-11-28

### Added

- `access_config` variable on the `instance_template` and `preemptible_and_regular_instance_templates` submodules. [#43]

### Fixed

- The `region` variable is passed to all relevant resources. [#42] [#44]

## [1.1.1] - 2019-10-25
### Fixed

- Fix bug with `distribution_policy_zones` forcing permadiff. [#37]

## [1.1.0] - 2019-10-23

### Added

- Added variable `project_id`. [#26]
- `preemptible_and_regular_instance_templates` submodule. [#18]
- `mig_with_percent` submodule. [#19]
- Support for shielded VMs. [#38]

## [1.0.0] - 2019-07-31

### Added

- `preemptible` variable on the Instance Template submodule. [#14]

### Changed

- Supported version of Terraform is 0.12. [#16]

## [0.2.0] - 2019-05-30

### Added

- `instance_group` output on the `mig` submodule. [#10]

## [0.1.0] - 2019-04-30

### Added
- `instance_template`, `mig`, and `umig` modules
- examples, basic tests and fixtures for all modules

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.4.0...HEAD
[1.4.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-vm/releases/tag/v0.1.0
[#10]: https://github.com/terraform-google-modules/terraform-google-vm/pull/10
[#14]: https://github.com/terraform-google-modules/terraform-google-vm/pull/14
[#16]: https://github.com/terraform-google-modules/terraform-google-vm/pull/16
[#18]: https://github.com/terraform-google-modules/terraform-google-vm/pull/18
[#19]: https://github.com/terraform-google-modules/terraform-google-vm/pull/19
[#26]: https://github.com/terraform-google-modules/terraform-google-vm/pull/26
[#37]: https://github.com/terraform-google-modules/terraform-google-vm/pull/37
[#38]: https://github.com/terraform-google-modules/terraform-google-vm/pull/38
[#42]: https://github.com/terraform-google-modules/terraform-google-vm/pull/42
[#43]: https://github.com/terraform-google-modules/terraform-google-vm/pull/43
[#44]: https://github.com/terraform-google-modules/terraform-google-vm/pull/44
[#52]: https://github.com/terraform-google-modules/terraform-google-vm/pull/52
[#56]: https://github.com/terraform-google-modules/terraform-google-vm/pull/56
[#57]: https://github.com/terraform-google-modules/terraform-google-vm/pull/57
