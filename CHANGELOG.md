# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

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

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-vm/compare/v1.1.0...HEAD
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
