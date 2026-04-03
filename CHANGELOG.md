# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

#### Phase 3 Complete - 90+ Packages, VPS & Bottle System

**New Formulas (28+ additional in Phase 2-3):**

**Server Software:**
- `redis` (7.4.2) - Key-value database
- `nginx` (1.27.4) - Web server with GCC 15 fix
- `caddy` (2.11.2) - Modern web server

**Rust Toolchain (22 tools):**
- `bandwhich` (0.23.1) - Network bandwidth monitor
- `dust` (1.2.4) - Disk usage analyzer
- `tokei` (13.0.0) - Code statistics
- `hyperfine` (1.19.0) - Command-line benchmark
- `bottom` - System monitor
- `gping` - Ping with graph
- `delta` - Git diff syntax highlighting
- `choose` - Human-friendly alternative to cut
- `grex` - Generate regex from examples
- `xh` - Friendly curl alternative
- `tre` - Tree with git awareness
- `gitui` - Terminal Git UI
- `broot` - Interactive tree view
- And 9 more...

**Infrastructure:**
- VPS deployment at https://homebrewloongarch64.site
- Bottle distribution system (binary packages)
- Containerized build system (systemd-nspawn + oma)
- Single compiler machine setup (192.168.50.244)

### Infrastructure Milestones

- **2026-03-31**: Phase 1 complete - 64 packages
- **2026-03-31**: Phase 2 complete - 82 packages
- **2026-04-01**: Phase 3 - 90+ packages, VPS deployment
- **2026-04-01**: Bottle distribution system online
- **2026-04-02**: AI Build Controller deployed
- **2026-04-03**: Containerized build system established (systemd-nspawn + oma)
- **2026-04-03**: Project structure cleaned and documented

#### Phase 1 Complete - 64 Packages Total

**New Formulas (19 additional):**

**Editors:**
- `emacs` (30.2) - Terminal-only GNU Emacs
- `nano` (8.7.1) - GNU text editor
- `micro` (2.0.15) - Modern terminal editor (Go)

**Shell & Terminal:**
- `zsh` (5.9) - Z shell with termcap fix
- `fish` (4.0.1) - Friendly interactive shell (Rust)
- `tmux` (3.5a) - Terminal multiplexer
- `zoxide` (0.9.7) - Smart cd command (Rust)
- `starship` (1.22.1) - Cross-shell prompt (Rust)

**Search Tools:**
- `fd` (10.3.0) - Fast file finder (Rust)
- `fzf` (0.60.3) - Fuzzy finder (Go)
- `ripgrep` (15.1.0) - Fast grep (Rust)
- `bat` (0.26.1) - Syntax-highlighting cat (Rust)
- `eza` (0.23.4) - Modern ls replacement (Rust)

**Development Tools:**
- `ninja` (1.13.2) - Build system
- `ccache` (4.11.2) - Compiler cache
- `htop` (3.4.1) - Interactive process viewer
- `gdb` (16.3) - GNU debugger
- `binutils` (2.46.0) - Binary tools
- `oniguruma` (6.9.10) - Regex library

**Infrastructure:**
- Complete CI/CD pipeline with 6-stage workflow
- Self-hosted runner setup scripts
- Architecture documentation and roadmap

### Fixed
- **zsh termcap type conflict**: Fixed configure.ac boolcodes detection
- **emacs build**: Terminal-only build avoiding X/gnutls dependencies
- **gdb build**: Minimal build without Python/Guile scripting

### Technical Highlights
- 100% build success rate for all 19 new packages
- Rust/Cargo toolchain fully operational
- System library reuse pattern refined
- Config.sub auto-update script created

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
