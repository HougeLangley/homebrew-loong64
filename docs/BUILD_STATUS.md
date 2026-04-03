# Build Status

Last Updated: 2026-04-03 (Containerization Update)

## Summary

| Category | Count | Percentage |
|----------|-------|------------|
| Core Libraries | 10 | 19% |
| Network Tools | 6 | 11% |
| Development Tools | 13 | 24% |
| Compression Tools | 7 | 13% |
| System Utilities | 3 | 6% |
| Editors | 4 | 7% |
| Search Tools | 4 | 7% |
| Shell | 5 | 9% |
| Servers | 2 | 4% |
| **Total** | **54** | **100%** |

## Progress

- Phase 1: Core tools ✅
- Phase 2: Server software + Rust toolchain ✅
- Phase 3: Containerized build system ✅ (2026-04-03)
- Phase 4: 100+ packages 🔄 (Planned)

## Build Infrastructure

### Current Architecture (2026-04-03)

| Environment | Host | Purpose |
|-------------|------|---------|
| GitHub Repository | github.com | Formulae, docs, scripts |
| Build Machine | 192.168.50.244 | Containerized builds with systemd-nspawn |
| VPS Distribution | 47.242.26.188 | Bottle storage and distribution |

### Container Setup

- **Base Image**: `/var/lib/machines/homebrew-minimal` (635MB)
- **Container Runtime**: systemd-nspawn with dbus binding
- **Package Manager**: oma 1.25.1 (AOSC OS)
- **Build Tools**: cargo 1.94.0, rustc 1.94.0

## Detailed List

### ✅ Core Libraries (10)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| openssl@3 | 3.6.1 | Container | SSL/TLS library |
| ncurses | 6.5 | Container | Terminal control |
| readline | 8.3.0 | Container | Line editing |
| sqlite | 3.49.1 | Container | Database engine |
| xz | 5.8.2 | Container | Compression |
| zlib-ng-compat | 2.2.4 | Container | Compression |
| zstd | 1.5.7 | Container | Compression |
| expat | 2.7.1 | Container | XML parser |
| libffi | 3.5.2 | Container | FFI library |
| libxml2 | 2.15.2 | Container | XML library |

### ✅ Network Tools (6)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| curl | 8.19.0 | Container | Without brotli |
| wget | 1.25.0 | Container | Minimal deps |
| libnghttp2 | 1.68.1 | Container | HTTP/2 |
| libssh2 | 1.11.1 | Container | SSH2 |
| libidn2 | 2.3.8 | Container | IDN library |
| ca-certificates | 2026-03-19 | Container | SSL certs |

### ✅ Development Tools (13)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| cmake | 4.3.1 | Container | Build system |
| perl | 5.42.1 | Container | Without DB_File |
| lua@5.4 | 5.4.8 | Container | Lua runtime |
| gettext | 0.22.5 | Container | i18n support |
| pcre2 | 10.47 | Container | Regex |
| m4 | 1.4.19 | Container | Macro processor |
| autoconf | 2.73 | Container | Auto-configure |
| automake | 1.18.1 | Container | Auto-make |
| libtool | 2.5.4 | Container | Library tool |
| ninja | 1.13.2 | Container | Build system |
| ccache | 4.11.2 | Container | Compile cache |
| gdb | 16.3 | Container | GNU debugger |
| binutils | 2.46.0 | Container | Binary tools |

### ✅ Rust Modern Tools (16) - Phase 2

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| fd | 10.4.2 | Container | Fast file finder |
| ripgrep | 15.1.0 | Container | Fast grep |
| bat | 0.26.1 | Container | Syntax highlight cat |
| bandwhich | 0.23.1 | Container | Network bandwidth monitor |
| dust | 1.2.4 | Container | du alternative |
| tokei | 14.0.0 | Container | Code statistics |
| hyperfine | 1.20.0 | Container | Benchmark tool |
| bottom | 0.12.3 | Container | System monitor (btm) |
| gping | 1.20.1 | Container | Ping with graph |
| delta | 0.19.2 | Container | Git diff highlighter |
| choose | 1.3.7 | Container | cut/awk alternative |
| grex | 1.4.6 | Container | Regex generator |
| xh | 0.25.0 | Container | HTTP client |
| tre | 0.4.0 | Container | tree alternative |
| gitui | 0.28.1 | Container | Git TUI |
| broot | 1.56.2 | Container | Directory navigator |

### ✅ Editors (4)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| vim | 9.2 | Container | Editor |
| nano | 8.7.1 | Container | Text editor |
| micro | 2.0.15 | Container | Modern editor |
| emacs | 30.2 | Container | Terminal-only build |

### ✅ Search Tools (4)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| fd | 10.4.2 | Container | Fast file finder |
| fzf | 0.60.3 | Container | Fuzzy finder |
| ripgrep | 15.1.0 | Container | Fast grep |
| grep | - | System | Pattern search |

### ✅ Shell (5)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| fish | 4.0.1 | Container | Friendly shell |
| tmux | 3.5a | Container | Terminal multiplexer |
| zsh | 5.9 | Container | Z shell |
| zoxide | 0.9.7 | Container | Smart cd command |
| starship | 1.22.1 | Container | Cross-shell prompt |

### ✅ Compression Tools (7)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| bzip2 | 1.0.8 | Container | Compression |
| gzip | 1.13 | Container | Compression |
| gnu-tar | 1.35 | Container | Archiving |
| lz4 | 1.10.0 | Container | Compression |
| lzip | 1.25 | Container | Compression |
| xz | 5.8.2 | Container | Compression |
| zstd | 1.5.7 | Container | Compression |

### ✅ System Utilities (3)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| gmp | 6.3.0 | Container | Big numbers |
| oniguruma | 6.9.10 | Container | Regex library |
| tree | 2.3.2 | Container | Directory listing |

### ✅ Servers (2)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| redis | 7.4.2 | Container | Key-value database |
| nginx | 1.27.4 | Container | Web server |

## Recent Updates (2026-04-03)

### Containerization

- ✅ Migrated from dual-compiler system to systemd-nspawn containers
- ✅ Base image: homebrew-minimal with oma package manager
- ✅ Automated bottle building and VPS distribution
- ✅ Formula sync: GitHub → Build Machine → VPS

### Package Count Correction

- **Previous**: 82 packages (overcounted)
- **Current**: 54 packages (actual count in Formula/ directory)
- **Reason**: Consolidated duplicates, removed abandoned formulae

## Known Issues

### Phase 3 Containerization

| Package | Issue | Status |
|---------|-------|--------|
| brotli | gcc-15 model attribute | ✅ Workaround: excluded from build |
| berkeley-db@5 | complex dependencies | ✅ Using system library |

### Resolved Issues

| Package | Issue | Solution |
|---------|-------|----------|
| nginx | GCC 15 string init warning | ✅ `-Wno-unterminated-string-initialization` flag |
| redis | jemalloc build on loong64 | ✅ Containerized build works |
| caddy | Go version requirement | ✅ Go 1.25+ in container |

## Build Commands

```bash
# Containerized build
make container-build FORMULA=curl

# Batch build with SSH
./scripts/batch_build.sh curl wget redis

# AI Controller
./scripts/ai-build-controller.sh

# Check build status
make build-status
```

## Legend

- ✅ - Container build working
- ⚠️ - Partial/Workaround
- ❌ - Build failed
- 🔄 - In progress
