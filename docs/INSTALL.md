# Installation Guide

本指南将帮助您在 LoongArch 64 架构的机器上安装和配置 Homebrew Loong64 Tap。

## 系统要求

- **架构**: LoongArch 64 (loong64)
- **操作系统**: AOSC OS 13.1+ / 龙芯 Loongnix / 其他兼容发行版
- **内存**: 建议 4GB+
- **磁盘空间**: 建议 50GB+
- **网络**: 可访问 GitHub 和 Homebrew 源

## 快速安装

### 1. 安装 Homebrew

如果尚未安装 Homebrew：

```bash
# 下载安装脚本
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o install-homebrew.sh

# 运行安装
/bin/bash install-homebrew.sh
```

### 2. 添加 Loong64 Tap

```bash
brew tap loongarch/homebrew-loong64
```

或者手动克隆：

```bash
mkdir -p $(brew --repo)/Library/Taps/loongarch
git clone https://github.com/loongarch/homebrew-loong64.git \
  $(brew --repo)/Library/Taps/loongarch/homebrew-loong64
brew tap loongarch/homebrew-loong64
```

### 3. 验证安装

```bash
# 检查 tap 是否可用
brew tap list | grep loongarch

# 查看可用包
brew search loongarch/homebrew-loong64/

# 安装测试包
brew install loongarch/homebrew-loong64/hello-loongarch
hello-loongarch
```

## 使用容器（推荐）

为了隔离环境，建议使用 systemd-nspawn 容器：

```bash
# 1. 创建容器目录
sudo mkdir -p /var/lib/machines/homebrew-build

# 2. 使用 debootstrap 或复制现有系统
sudo pacstrap -c /var/lib/machines/homebrew-build base base-devel

# 3. 进入容器
sudo systemd-nspawn -D /var/lib/machines/homebrew-build --user=brewbuilder

# 4. 在容器内安装 Homebrew 和 Tap
# ... 按照上面的步骤
```

## 基本使用

### 安装软件包

```bash
# 从本地 tap 安装
brew install loongarch/homebrew-loong64/curl
brew install loongarch/homebrew-loong64/wget

# 或使用简称（如果已 tap）
brew install curl wget gettext
```

### 批量构建

使用提供的脚本批量构建所有 formula：

```bash
# 进入 tap 目录
cd $(brew --repo)/Library/Taps/loongarch/homebrew-loong64

# 运行批量构建脚本
./scripts/batch-build.sh -a

# 或构建特定包
./scripts/batch-build.sh curl wget vim
```

### 查看已安装包

```bash
# 列出所有已安装的包
brew list

# 查看包信息
brew info curl

# 检查依赖
brew deps curl
```

## 故障排除

### 问题: "cannot guess build type"

**原因**: autotools 无法识别 loongarch64 架构

**解决**: 确保 formula 包含架构修复：

```ruby
cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
args << "--build=#{cpu}-unknown-linux-gnu"
```

### 问题: "invalid argument of 'model' attribute"

**原因**: gcc-15 不支持 brotli 的 model 属性

**解决**: 使用本地 tap 的精简版 formula，或跳过 brotli：

```bash
brew install loongarch/homebrew-loong64/curl  # 已移除 brotli
```

### 问题: 依赖冲突

**原因**: 某些包依赖从源码构建的 berkeley-db@5 或 gmp

**解决**: 使用系统库版本：

```bash
brew install loongarch/homebrew-loong64/gmp
brew install loongarch/homebrew-loong64/berkeley-db@5
```

### 问题: 下载失败

**原因**: 网络问题或 URL 变更

**解决**: 

```bash
# 清除缓存
brew cleanup -s
rm -rf ~/Library/Caches/Homebrew/downloads/*

# 重试
brew fetch <formula>
```

## 环境变量

建议添加到 `~/.bashrc` 或 `~/.zshrc`：

```bash
# Homebrew 基础配置
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_DEVELOPER=1

# 使用系统 Ruby
export HOMEBREW_USE_RUBY_FROM_PATH=1

# 路径配置
export PATH="/home/brew-build/brew/bin:/home/brew-build/brew/sbin:$PATH"

# 库路径
export LD_LIBRARY_PATH="/home/brew-build/brew/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/home/brew-build/brew/lib/pkgconfig:$PKG_CONFIG_PATH"

# Rust 环境（如果使用）
source $HOME/.cargo/env 2>/dev/null || true
```

## 更新 Tap

```bash
# 更新所有 tap
brew update

# 或单独更新
cd $(brew --repo)/Library/Taps/loongarch/homebrew-loong64
git pull origin main
brew tap loongarch/homebrew-loong64
```

## 卸载

```bash
# 卸载特定包
brew uninstall <package>

# 卸载 tap 中的所有包
brew uninstall $(brew list | grep loongarch)

# 移除 tap
brew untap loongarch/homebrew-loong64
```

## 获取帮助

- 查看 [README.md](../README.md) 了解项目概览
- 查看 [BUILD_STATUS.md](BUILD_STATUS.md) 了解构建状态
- 在 GitHub 提交 [Issue](https://github.com/loongarch/homebrew-loong64/issues)

## 下一步

安装完成后，您可以：

1. 查看 [BUILD_STATUS.md](BUILD_STATUS.md) 了解可用包列表
2. 使用 `brew install` 安装需要的软件
3. 参考 [CONTRIBUTING.md](../CONTRIBUTING.md) 为项目贡献代码
