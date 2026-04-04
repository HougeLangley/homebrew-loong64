# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2025-04-04

### 🎉 Major Milestone: 58 Bottles Complete

Today we achieved **100% build success rate** for 24 packages, bringing total bottles to **58** (836M).

### Added - 24 New Bottles (100% Success Rate)

#### P0 Priority Packages
- `git` (2.48.1) - Version control, built without brotli for GCC 15 compatibility
- `gmp` (6.3.0) - GNU multiple precision library, using system library shim

#### Rust CLI Tools (4 packages)
- `procs` (0.14.9) - Modern replacement for ps
- `mcfly` (0.9.2) - Shell history tool
- `exa` (0.10.1) - Modern ls replacement (legacy)
- `dog` (0.1.0) - Command-line DNS client

#### High-Frequency Tools (6 packages)
- `htop` (3.4.1) - Interactive process viewer
- `tmux` (3.5a) - Terminal multiplexer
- `jq` (1.7.1) - JSON processor
- `ccache` (4.10.2) - Compiler cache
- `zsh` (5.9) - Z Shell
- `vim` (9.1.1000) - Text editor

#### Practical Tools (6 packages)
- `fish` (4.0.1) - Friendly interactive shell
- `nano` (8.7.1) - Simple text editor
- `ninja` (1.13.2) - Fast build system
- `caddy` (2.11.2) - Modern web server
- `nginx` (1.27.4) - High-performance web server
- `redis` (7.4.2) - In-memory data store

#### Low-Level Dependencies (6 packages)
- `gettext` (0.22.5) - Internationalization library
- `oniguruma` (6.9.10) - Regular expression library
- `unzip` (6.0) - ZIP extraction tool
- `perl` (5.42.1) - Perl programming language
- `berkeley-db@5` (5.3.28) - Oracle Berkeley DB
- `binutils` (2.45) - GNU binary utilities (582M bottle)

### Technical Highlights

#### Build Statistics
- **Total bottles**: 58 (+24 today)
- **Total size**: 836M
- **Build success rate**: 100% (24/24)
- **Build duration**: ~4 hours

#### Key Solutions
1. **GCC 15 Compatibility**: 
   - Disabled brotli for git/vim (model attribute issue)
   - Used system oniguruma for jq
   - Added `-Wno-incompatible-pointer-types` for berkeley-db@5

2. **LoongArch Support**:
   - Updated config.sub/guess for htop, zsh, gettext
   - Upgraded libc to 0.2.184 for exa
   - Disabled docker feature for procs (nix crate issue)

3. **Build System**:
   - Containerized builds with systemd-nspawn
   - Automated VPS upload
   - Proper cleanup after each build

#### Infrastructure
- **Build machine**: 192.168.50.244 (AOSC OS, GCC 15.2.0)
- **VPS**: 47.242.26.188 (bottle storage)
- **Container**: systemd-nspawn with oma package manager

### Documentation Updates

#### Updated Files
- `README.md` - Complete rewrite with bottle information
- `CHANGELOG.md` - Added today's build record
- All documentation verified in correct repository location

### Repository Structure

```
Total Formulas: 122
Total Bottles: 58
Total Size: 836M
```

### Known Patterns

| Issue | Affected Packages | Solution |
|-------|------------------|----------|
| GCC 15 model attribute | git, vim | Disable brotli |
| Autotools arch detection | htop, zsh, gettext | Update config.sub/guess |
| Rust libc compatibility | exa | cargo update libc |
| nix crate on LoongArch | procs | --no-default-features |

## [0.1.0] - 2024-03-31 to 2025-04-03

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
- **2025-04-04**: 24 new bottles added, total 58 bottles (836M)

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

### Known Issues

- Some formulas still require manual `--build` parameter
- jq and oniguruma need autotools arch fixes
- htop has autotools detection issues
- ripgrep requires Rust toolchain

[Unreleased]: https://github.com/loongarch/homebrew-loong64/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/loongarch/homebrew-loong64/releases/tag/v0.2.0
[0.1.0]: https://github.com/loongarch/homebrew-loong64/releases/tag/v0.1.0
