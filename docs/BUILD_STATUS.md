# Build Status

Last Updated: 2026-03-31

## Summary

| Category | Count | Percentage |
|----------|-------|------------|
| Core Libraries | 10 | 17% |
| Network Tools | 6 | 10% |
| Development Tools | 18 | 31% |
| Compression Tools | 7 | 12% |
| System Utilities | 8 | 14% |
| Editors | 4 | 7% |
| Search Tools | 4 | 7% |
| Shell | 2 | 3% |
| **Total** | **59** | **100%** |

## Detailed List

### ✅ Core Libraries (10)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| openssl@3 | 3.6.1 | Official formula | SSL/TLS library |
| ncurses | 6.5 | Official formula | Terminal control |
| readline | 8.3.0 | Official formula | Line editing |
| sqlite | 3.49.1 | Official formula | Database engine |
| xz | 5.8.2 | Official formula | Compression |
| zlib-ng-compat | 2.2.4 | Official formula | Compression |
| zstd | 1.5.7 | Official formula | Compression |
| expat | 2.7.1 | Official formula | XML parser |
| libffi | 3.5.2 | Official formula | FFI library |
| libxml2 | 2.15.2 | Official formula | XML library |

### ✅ Network Tools (6)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| curl | 8.19.0 | Custom formula | Without brotli |
| wget | 1.25.0 | Custom formula | Minimal deps |
| libnghttp2 | 1.68.1 | Official formula | HTTP/2 |
| libssh2 | 1.11.1 | Official formula | SSH2 |
| libidn2 | 2.3.8 | Official formula | IDN library |
| ca-certificates | 2026-03-19 | Official formula | SSL certs |

### ✅ Development Tools (17)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| cmake | 4.3.1 | Official formula | Build system |
| python@3.13 | 3.13.2 | Official formula | Python runtime |
| perl | 5.42.1 | Custom formula | Without DB_File |
| lua@5.4 | 5.4.8 | Official formula | Lua runtime |
| gettext | 0.22.5 | Custom formula | i18n support |
| vim | 9.2 | System shim | Editor |
| pcre2 | 10.47 | Official formula | Regex |
| m4 | 1.4.19 | Official formula | Macro processor |
| autoconf | 2.73 | Official formula | Auto-configure |
| automake | 1.18.1 | Official formula | Auto-make |
| libtool | 2.5.4 | Official formula | Library tool |
| **ninja** | **1.13.2** | **Manual build** | **Build system** |
| **htop** | **3.4.1** | **Manual build** | **System monitor** |
| **nano** | **8.7.1** | **Manual build** | **Text editor** |
| **ripgrep** | **15.1.0** | **Cargo build** | **Fast grep** |
| **jq** | **1.8.1** | **Manual build** | **JSON processor** |
| **ccache** | **4.11.2** | **CMake** | **Compile cache** |

### ✅ Editors (4)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| vim | 9.2 | System shim | Editor |
| nano | 8.7.1 | Manual build | Text editor |
| **micro** | **2.0.15** | **Go build** | **Modern editor** |
| **bat** | **0.26.1** | **Cargo build** | **Syntax highlight cat** |

### ✅ Search Tools (4)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| **fd** | **10.3.0** | **Cargo build** | **Fast file finder** |
| **fzf** | **0.60.3** | **Go build** | **Fuzzy finder** |
| ripgrep | 15.1.0 | Cargo build | Fast grep |
| grep | - | System | Pattern search |

### ✅ Shell (2)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| **fish** | **4.0.1** | **Cargo build** | **Friendly shell** |
| **tmux** | **3.5a** | **Autotools** | **Terminal multiplexer** |

### ✅ Compression Tools (7)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| bzip2 | 1.0.8 | Official formula | Compression |
| gzip | 1.13 | Official formula | Compression |
| gnu-tar | 1.35 | Official formula | Archiving |
| lz4 | 1.10.0 | Official formula | Compression |
| lzip | 1.25 | Official formula | Compression |
| xz | 5.8.2 | Official formula | Compression |
| zstd | 1.5.7 | Official formula | Compression |

### ✅ System Utilities (8)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| gmp | 6.3.0 | System library | Big numbers |
| berkeley-db@5 | 5.3.28 | System library | Database |
| acl | 2.3.2 | Official formula | Access control |
| attr | 2.5.2 | Official formula | Extended attrs |
| json-c | 0.18 | Official formula | JSON parser |
| libxcrypt | 4.5.2 | Official formula | Crypt library |
| **binutils** | **2.46.0** | **Official formula** | **Binary tools** |
| **oniguruma** | **6.9.10** | **Manual build** | **Regex library** |

### ✅ Others (5)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| tree | 2.3.2 | Official formula | Directory listing |
| hello | 2.12.3 | Official formula | Test program |
| hello-loongarch | 2.12.1 | Official formula | Demo package |
| libedit | - | Official formula | Line editor |
| mpdecimal | 4.0.1 | Official formula | Decimal math |
| gdbm | 1.26 | Official formula | GNU dbm |
| pkgconf | 2.5.1 | Official formula | pkg-config |
| libsodium | 1.0.21 | Official formula | Crypto library |
| libpng | - | Official formula | PNG library |
| libunistring | 1.3.0 | Official formula | Unicode strings |
| unzip | 6.0 | System shim | Archive tool |

## Known Issues

### Resolved Issues

| Package | Issue | Solution |
|---------|-------|----------|
| jq | autotools arch detection | ✅ Updated config.sub |
| ripgrep | autotools arch detection | ✅ Use cargo build |
| htop | autotools arch detection | ✅ Updated config.sub |
| oniguruma | autotools arch detection | ✅ Updated config.sub |
| ninja | unzip dependency | ✅ Manual build with Python |

### Pending Issues

| Package | Issue | Workaround |
|---------|-------|------------|
| brotli | gcc-15 model attribute | Skip or use system |
| berkeley-db@5 | autotools arch detection | Use system library |
| zsh | termcap.c type conflict | Pending investigation |

## Legend

- ✅ - Successfully built
- ⚠️ - Partial/Workaround
- ❌ - Build failed
- 🔄 - In progress
