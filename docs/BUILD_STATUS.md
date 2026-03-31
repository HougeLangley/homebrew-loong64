# Build Status

Last Updated: 2024-03-31

## Summary

| Category | Count | Percentage |
|----------|-------|------------|
| Core Libraries | 10 | 22% |
| Network Tools | 6 | 13% |
| Development Tools | 11 | 25% |
| Compression Tools | 7 | 16% |
| System Utilities | 6 | 13% |
| Others | 5 | 11% |
| **Total** | **45** | **100%** |

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

### ✅ Development Tools (11)

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

### ✅ System Utilities (6)

| Package | Version | Build Method | Notes |
|---------|---------|--------------|-------|
| gmp | 6.3.0 | System library | Big numbers |
| berkeley-db@5 | 5.3.28 | System library | Database |
| acl | 2.3.2 | Official formula | Access control |
| attr | 2.5.2 | Official formula | Extended attrs |
| json-c | 0.18 | Official formula | JSON parser |
| libxcrypt | 4.5.2 | Official formula | Crypt library |

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

### Packages with Build Issues

| Package | Issue | Workaround |
|---------|-------|------------|
| brotli | gcc-15 model attribute | Skip or use system |
| jq | autotools arch detection | Pending fix |
| ripgrep | autotools arch detection | Pending fix |
| htop | autotools arch detection | Pending fix |
| oniguruma | autotools arch detection | Pending fix |

## Legend

- ✅ - Successfully built
- ⚠️ - Partial/Workaround
- ❌ - Build failed
- 🔄 - In progress
