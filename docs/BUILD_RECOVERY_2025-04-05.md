# Build Recovery Guide - 2025-04-05

## Current Status

**Date**: 2025-04-05  
**Issue**: Build machine (192.168.50.244) SSH connection failure

## Background

Today's build session started 4 parallel container builds:
- `aria2` v1.37.0
- `git-lfs` v3.6.1 ✅ (confirmed uploaded)
- `gh` v2.63.2
- `tig` v2.6.0

At approximately 14:20 UTC, SSH connection to build machine failed.

## Recovery Steps

### 1. Check Build Machine Status

```bash
# From local machine
ping 192.168.50.244
ssh houge@192.168.50.244
```

### 2. If SSH Fails - Restart SSH Service

Physical access or IPMI required:
```bash
# On build machine (aosc-loongarch64)
sudo systemctl restart sshd
sudo systemctl status sshd
```

### 3. Check Pending Bottles

Once SSH is restored:

```bash
ssh houge@192.168.50.244 '
  echo "=== Pending Bottles ==="
  ls -la /tmp/*.bottle.tar.gz 2>/dev/null
  
  echo ""
  echo "=== Build Containers ==="
  sudo machinectl list
  
  echo ""
  echo "=== Cellar Contents ==="
  ls -la /brew/Cellar/ 2>/dev/null | head -20
'
```

### 4. Upload Pending Bottles

```bash
# Upload any missing bottles to VPS
scp /tmp/aria2--*.tar.gz root@47.242.26.188:/var/www/bottles/loong64/
scp /tmp/gh--*.tar.gz root@47.242.26.188:/var/www/bottles/loong64/
scp /tmp/tig--*.tar.gz root@47.242.26.188:/var/www/bottles/loong64/
```

### 5. Cleanup Containers

```bash
ssh houge@192.168.50.244 '
  sudo machinectl terminate homebrew-build-aria2 2>/dev/null || true
  sudo machinectl terminate homebrew-build-gh 2>/dev/null || true
  sudo machinectl terminate homebrew-build-tig 2>/dev/null || true
  sudo rm -rf /var/lib/machines/homebrew-build-aria2
  sudo rm -rf /var/lib/machines/homebrew-build-gh
  sudo rm -rf /var/lib/machines/homebrew-build-tig
'
```

### 6. Continue Batch 2-3 Builds

After recovery, continue with:

**Batch 2**:
- `tree` - Directory tree display
- `ncdu` - Disk usage analyzer
- `btop` - Modern system monitor

**Batch 3**:
- `nmap` - Network scanner
- `tcpdump` - Packet analyzer

## VPS Status Check

```bash
ssh root@47.242.26.188 '
  echo "Total bottles:"
  ls /var/www/bottles/loong64/*.tar.gz | wc -l
  
  echo ""
  echo "Recent uploads:"
  ls -lt /var/www/bottles/loong64/*.tar.gz | head -10
'
```

## Prevention Measures

1. **Add SSH keepalive** to prevent timeout during long builds:
   ```bash
   # In ~/.ssh/config
   Host 192.168.50.244
     ServerAliveInterval 60
     ServerAliveCountMax 3
   ```

2. **Monitor build progress** with periodic status checks

3. **Upload bottles immediately** after creation, don't wait for batch completion

## Contact

If build machine remains inaccessible, may need physical reboot or network troubleshooting.
