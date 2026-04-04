# Homebrew Loong64 Tap

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-loongarch64-red.svg)](https://github.com/loongarch/homebrew-loong64)
[![Homebrew](https://img.shields.io/badge/homebrew-5.0+-orange.svg)](https://brew.sh)
[![Packages](https://img.shields.io/badge/formulas-122-brightgreen.svg)](./Formula)
[![Bottles](https://img.shields.io/badge/bottles-58-blue.svg)](docs/BUILD_STATUS.md)

针对 LoongArch 64 (loong64) 架构优化的 Homebrew 第三方仓库，提供预编译的 bottles 和适配的 Formula。

🌐 **VPS**: https://homebrewloongarch64.site  
📦 **Bottles**: https://homebrewloongarch64.site/bottles/loong64/

## 简介

本仓库提供了专为 LoongArch 64 架构适配的 Homebrew Formulae，解决了在龙芯平台上构建软件时的常见兼容性问题：

- **✅ 预编译 Bottles** - 58+ 包提供二进制 bottles，无需等待编译
- **🔧 架构识别修复** - 修复 autotools `--build` 参数识别
- **📦 系统库复用** - 复用 AOSC OS 等系统的预编译库
- **✂️ 依赖精简** - 移除/替换在 loong64 上构建困难的依赖
- **🛠️ GCC 15 兼容** - 解决新版本编译器警告和错误

## 快速开始

### 添加 Tap

```bash
brew tap HougeLangley/homebrew-loong64 https://github.com/HougeLangley/homebrew-loong64
```

### 安装软件包

```bash
# 使用预编译 bottle（推荐，快速）
brew install git vim fd ripgrep

# 从源码构建（较慢）
brew install --build-from-source git
```

## 可用软件包

### 已构建 Bottles（58个）

| 类别 | 包名 | 版本 |
|------|------|------|
| **核心工具** | git, vim, curl, wget, gmp, jq, unzip, gettext | 最新 |
| **Shell** | zsh, fish, tmux | 5.9, 4.0.1, 3.5a |
| **编辑器** | vim, nano, micro | 9.1.1000, 8.7.1, 2.0.15 |
| **Rust 工具** | fd, ripgrep, bat, exa/eza, dust, bottom, procs, tokei, hyperfine | 最新 |
| **开发工具** | ninja, ccache, binutils, perl | 1.13.2, 4.10.2, 2.45, 5.42.1 |
| **Git 工具** | lazygit, gitui, delta | 最新 |
| **系统监控** | htop, bottom, bandwhich, procs | 3.4.1, 0.10.2, 0.23.1, 0.14.9 |
| **搜索工具** | fd, ripgrep, fzf | 10.2.0, 15.1.0, 0.60.3 |
| **Web 服务器** | nginx, redis, caddy | 1.27.4, 7.4.2, 2.11.2 |
| **其他** | dog, mcfly, starship, zoxide, xh, choose, grex | 最新 |

### Formula 列表（122个）

完整 Formula 列表请查看 [Formula/](./Formula) 目录。

## 仓库结构

```
.
├── Formula/              # 122个 Homebrew Formulas
├── scripts/              # 构建脚本
│   ├── ai-build-controller.sh
│   ├── vps-sync-service.sh
│   └── batch_build.sh
├── docs/                 # 文档
│   ├── BUILD_STATUS.md   # 构建状态
│   ├── AI_BUILD_SYSTEM.md
│   └── INSTALL.md
├── README.md             # 本文件
├── CHANGELOG.md          # 更新日志
└── CONTRIBUTING.md       # 贡献指南
```

## 技术方案

### 1. 预编译 Bottles

58个热门包提供预编译 bottles，安装无需等待：

```bash
# 从 bottle 安装（秒级）
brew install git  # 81M bottle，秒装

# 从源码构建（分钟级）
brew install --build-from-source git  # 需编译
```

Bottles 存储在 VPS: `https://homebrewloongarch64.site/bottles/loong64/`

### 2. 容器化构建系统

每个包在独立容器中构建，确保环境纯净：

```
1. 复制基础镜像 → homebrew-build-<package>
2. 启动 systemd-nspawn 容器
3. 使用 oma 安装依赖（不是 apt）
4. cargo/make 编译
5. 生成 bottle 并上传 VPS
6. 销毁容器
```

### 3. 架构识别修复

```ruby
cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
args << "--build=#{cpu}-unknown-linux-gnu"
```

### 4. GCC 15 兼容性

| 问题 | 解决方法 |
|------|----------|
| brotli model 属性 | 禁用 brotli（git, vim） |
| 隐式 int 警告 | 添加 `-Wno-implicit-int` |
| 指针类型不兼容 | 添加 `-Wno-incompatible-pointer-types` |
| 字符串初始化 | 添加 `-Wno-unterminated-string-initialization` |

### 5. 系统库复用

对于 GCC 15 编译困难的包，使用系统库：

```bash
# gmp 使用系统库
mkdir -p $(brew --cellar)/gmp/6.3.0/{lib,include}
cp /usr/lib/libgmp* $(brew --cellar)/gmp/6.3.0/lib/
brew link gmp
```

## 构建环境

### 三节点架构

| 节点 | IP | 用途 | 操作系统 |
|------|-----|------|----------|
| **GitHub 仓库** | - | 代码管理 | - |
| **编译机** | 192.168.50.244 | 唯一构建节点 | AOSC OS LoongArch |
| **VPS 分发** | 47.242.26.188 | 存储 bottles | - |

### 编译机配置

- **OS**: AOSC OS 13.1.5
- **架构**: LoongArch64 (LP64D)
- **编译器**: GCC 15.2.0
- **包管理**: oma（不是 apt）
- **容器**: systemd-nspawn

## 今日更新（2025-04-04）

新增 24 个 bottles：

- **P0 核心**: git 2.48.1, gmp 6.3.0
- **Rust CLI**: procs, mcfly, exa, dog
- **高频工具**: htop, tmux, jq, ccache, zsh, vim
- **实用工具**: fish, nano, ninja, caddy, nginx, redis
- **底层依赖**: gettext, oniguruma, unzip, perl, berkeley-db, binutils

VPS bottles: 58个 → 836M

## 贡献

欢迎提交 PR！详见 [CONTRIBUTING.md](./CONTRIBUTING.md)

### 快速贡献指南

1. Fork 本仓库
2. 在 `Formula/` 添加 `.rb` 文件
3. 确保包含 LoongArch 架构修复
4. 提交 PR

## 路线图

- **Phase 1** ✅ (64 包) - 核心工具链
- **Phase 2** ✅ (82 包) - 服务器软件 + Rust 工具链
- **Phase 3** ✅ (122 Formulas, 58 Bottles) - 完整开发环境 + Bottle 分发
- **Phase 4** 🔄 (150+ 包) - 持续扩展

## 相关项目

- [Homebrew](https://github.com/Homebrew/brew) - macOS 和 Linux 的包管理器
- [AOSC OS](https://aosc.io) - 龙芯优化的 Linux 发行版

## 许可证

[MIT License](./LICENSE)

## 致谢

感谢 AOSC OS 社区提供的系统库支持。

---

**当前状态**: 122 Formulas | 58 Bottles | 持续更新中
