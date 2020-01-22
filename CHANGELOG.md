# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [1.5.0](https://www.github.com/terraform-google-modules/terraform-google-vm/compare/v1.4.1...v1.5.0) (2020-01-22)


### Features

* Change the readme formatting ([f2e87b3](https://www.github.com/terraform-google-modules/terraform-google-vm/commit/f2e87b3912e0095fde909cb5e0e1b4706d315edb))

### [1.4.1](https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.4.0...v1.4.1) (2020-01-21)


### Bug Fixes

* derive project id for instance from instance template ([#63](https://github.com/terraform-google-modules/terraform-google-vm/issues/63)) ([3e2c8cd](https://github.com/terraform-google-modules/terraform-google-vm/commit/3e2c8cdeb2d0e6f1fe53bc2d0a9369c9dc59f013))

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
[#57]: https://github.com/terraform-google-modules/terraform-google-vm/pull/57
