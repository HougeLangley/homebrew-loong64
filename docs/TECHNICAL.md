# Technical Notes

本文档详细说明 LoongArch 64 架构上 Homebrew 构建的技术细节和解决方案。

## 目录

- [架构识别问题](#架构识别问题)
- [系统库复用方案](#系统库复用方案)
- [依赖精简策略](#依赖精简策略)
- [已知问题与解决](#已知问题与解决)

## 架构识别问题

### 问题描述

autotools 默认不认识 `loongarch64` 架构，导致构建时失败：

```
configure: error: cannot guess build type; you must specify one
```

### 根本原因

1. Homebrew 的 `oldest_cpu` 方法返回 `:dunno`
2. config.sub 不认识 `loongarch-linux-gnu`

### 解决方案

#### 1. 修复 Homebrew core

修改 `$(brew --repo)/Library/Homebrew/hardware.rb`：

```ruby
def oldest_cpu(_version = nil)
  if Hardware::CPU.intel?
    # ... existing code ...
  elsif Hardware::CPU.ppc? && Hardware::CPU.is_64_bit?
    # ... existing code ...
  elsif Hardware::CPU.loongarch?
    :loongarch64  # 添加这一行
  else
    Hardware::CPU.family
  end
end
```

#### 2. Formula 中使用架构参数

在所有使用 autotools 的 formula 中添加：

```ruby
def install
  cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
  
  args = std_configure_args + [
    "--build=#{cpu}-unknown-linux-gnu",
  ]
  
  system "./configure", *args
  system "make", "install"
end
```

## 系统库复用方案

### 适用场景

以下包在 gcc-15 下编译困难或失败：

- **gmp**: 严格的 long long 检查失败
- **berkeley-db@5**: POSIX mutexes 不支持
- **unzip**: localtime 函数签名问题

### 实现方式

#### 方法 1: 直接复制系统库

```ruby
def install
  # 创建目录
  system "mkdir", "-p", "#{lib}"
  system "mkdir", "-p", "#{include}"
  
  # 复制系统库文件
  system "cp", "/usr/lib/libgmp*", "#{lib}/"
  system "cp", "/usr/include/gmp*.h", "#{include}/"
end
```

#### 方法 2: 创建 Symbolic Link

```ruby
def install
  # 创建 Cellar 目录结构
  system "mkdir", "-p", "#{prefix}"
  
  # 链接系统库
  system "ln", "-sf", "/usr/lib/libgmp.so", "#{lib}/libgmp.so"
  system "ln", "-sf", "/usr/include/gmp.h", "#{include}/gmp.h"
end
```

### 注意事项

1. **版本匹配**: 确保系统库版本与 formula 声明一致
2. **ABI 兼容**: LoongArch 的 ABI 在不同版本可能不同
3. **许可证**: 确保系统库许可证允许重新分发

## 依赖精简策略

### 策略 1: 移除可选依赖

```ruby
# 原始依赖
depends_on "brotli"
depends_on "pcre2"
depends_on "libpsl"

# 精简后
# depends_on "brotli"  # 移除：gcc-15 不支持
depends_on "pcre2" => :optional  # 改为可选
# depends_on "libpsl"  # 移除：非必需
```

### 策略 2: 使用 configure 选项禁用

```ruby
def install
  args = [
    "--prefix=#{prefix}",
    "--disable-brotli",     # 禁用 brotli 支持
    "--without-pcre2",      # 不使用 pcre2
    "--disable-nls",        # 禁用国际化（gettext 可能不可用）
  ]
  
  system "./configure", *args
  system "make", "install"
end
```

### 策略 3: 创建 shim 工具

对于无法从源码构建的工具，使用系统版本：

```ruby
class Unzip < Formula
  def install
    # 创建 shim 脚本
    (bin/"unzip").write <<~EOS
      #!/bin/bash
      exec /usr/sbin/unzip "$@"
    EOS
    chmod 0755, bin/"unzip"
  end
end
```

## 已知问题与解决

### 问题 1: brotli 编译失败

**错误信息**:
```
error: invalid argument of 'model' attribute
static const BROTLI_MODEL("small") uint8_t kBrotliDictionaryData[] = {
```

**原因**: gcc-15 不支持 `__attribute__((model("small")))` 在 LoongArch 上

**解决**:
- 方案 A: 使用系统 brotli（如果可用）
- 方案 B: 在 formula 中禁用 brotli 支持
- 方案 C: 降级到 gcc-12/13

### 问题 2: gmp 严格检查失败

**错误信息**:
```
checking compiler gcc-15 -O2 -pedantic ... no, long long reliability test 1
configure: error: could not find a working compiler
```

**原因**: gmp 的 configure 脚本对编译器进行严格测试

**解决**:
```bash
# 使用系统 gmp
brew install loongarch/homebrew-loong64/gmp
```

### 问题 3: berkeley-db@5 POSIX mutexes

**错误信息**:
```
configure: error: unable to find POSIX 1003.1 mutex interfaces
# 或
configure: error: Support for FCNTL mutexes was removed in BDB 4.8.
```

**原因**: AOSC OS 的 POSIX mutex 实现与 BDB 不兼容

**解决**:
```bash
# 使用系统 berkeley-db
brew install loongarch/homebrew-loong64/berkeley-db@5
```

### 问题 4: unzip localtime 函数

**错误信息**:
```
error: too many arguments to function 'localtime'; expected 0, have 1
```

**原因**: unzip 的补丁与 gcc-15 不兼容

**解决**: 使用系统 unzip

### 问题 5: autotools 架构检测

**错误信息**:
```
configure: error: cannot guess build type; you must specify one
```

**原因**: config.sub 不认识 loongarch64

**解决**: 在 formula 中显式指定 `--build` 参数

## 调试技巧

### 查看详细日志

```bash
# 构建时保留日志
brew install --verbose --debug <formula>

# 查看日志文件
cat ~/Library/Logs/Homebrew/<formula>/01.configure.log
```

### 手动测试 configure

```bash
# 进入构建目录
cd $(brew --cache)/<formula>-*/

# 手动运行 configure
./configure --build=loongarch64-unknown-linux-gnu
```

### 检查系统库

```bash
# 查看系统库
ls /usr/lib/libgmp*
ls /usr/include/gmp*

# 检查 pkg-config
pkg-config --exists gmp && echo "gmp found"
```

## 性能优化

### 并行构建

```ruby
def install
  ENV.make_jobs = 4  # 限制并行度，避免内存不足
  system "make", "-j#{ENV.make_jobs}"
end
```

### 缓存配置

```bash
# 启用 Homebrew 缓存
export HOMEBREW_CACHE="$HOME/.cache/Homebrew"

# 保留下载文件
export HOMEBREW_NO_CLEANUP=1
```

## 参考资料

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [LoongArch ABI Documentation](https://loongson.github.io/LoongArch-Documentation/)
- [AOSC OS Package Guidelines](https://wiki.aosc.io/developer/packaging/package-styling-manual/)
