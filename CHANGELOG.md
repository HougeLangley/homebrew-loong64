# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release with 10 custom formulas
- Support for LoongArch 64 (loong64) architecture
- System library reuse for problematic packages
- Documentation and contribution guidelines

## [0.1.0] - 2024-03-31

### Added

#### Formulas
- `curl` (8.19.0) - Network transfer tool without brotli
- `wget` (1.25.0) - File download tool with minimal deps
- `gettext` (0.22.5) - Internationalization library
- `gmp` (6.3.0) - Big number library (system copy)
- `berkeley-db@5` (5.3.28) - Database library (system copy)
- `perl` (5.42.1) - Perl interpreter without DB_File
- `vim` (9.2) - Text editor shim
- `git` (2.53.0) - Version control (simplified)
- `jq` (1.7.1) - JSON processor
- `unzip` (6.0) - Archive tool shim

#### Documentation
- README.md - Project overview and quick start
- CONTRIBUTING.md - Contribution guidelines
- INSTALL.md - Installation instructions
- BUILD_STATUS.md - Package build status
- TECHNICAL.md - Technical notes and solutions

#### Scripts
- batch-build.sh - Batch build helper script

#### CI/CD
- GitHub Actions workflow for formula testing
- Issue templates for bug reports and feature requests

### Technical Highlights

- Architecture detection fix for `--build=loongarch64-unknown-linux-gnu`
- System library reuse pattern for gmp and berkeley-db@5
- Dependency trimming to avoid brotli build issues
- Formula templates for common LoongArch issues

### Known Issues

- Some formulas still require manual `--build` parameter
- jq and oniguruma need autotools arch fixes
- htop has autotools detection issues
- ripgrep requires Rust toolchain

[Unreleased]: https://github.com/loongarch/homebrew-loong64/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/loongarch/homebrew-loong64/releases/tag/v0.1.0
