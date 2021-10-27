# Changelog

All notable changes to this project will be documented in this file. See [conventional-commits](https://www.conventionalcommits.org/) for commit guidelines.

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
