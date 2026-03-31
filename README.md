# Homebrew Loong64 Tap

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-loongarch64-red.svg)](https://github.com/loongarch/homebrew-loong64)
[![Homebrew](https://img.shields.io/badge/homebrew-5.0+-orange.svg)](https://brew.sh)
[![Packages](https://img.shields.io/badge/packages-82-brightgreen.svg)](docs/BUILD_STATUS.md)

针对 LoongArch 64 (loong64) 架构优化的 Homebrew 第三方仓库。

## 简介

本仓库提供了专为 LoongArch 64 架构适配的 Homebrew Formulae，解决了在龙芯平台上构建软件时的常见兼容性问题，包括：

- **架构识别修复** - 修复 autotools `--build` 参数识别
- **系统库复用** - 复用 AOSC OS 等系统的预编译库
- **依赖精简** - 移除/替换在 loong64 上构建困难的依赖
- **GCC 15 兼容** - 解决新版本编译器警告和错误

## 快速开始

### 添加 Tap

```bash
brew tap loongarch/homebrew-loong64
```

### 安装软件包

```bash
# 核心工具
brew install loongarch/homebrew-loong64/curl
brew install loongarch/homebrew-loong64/wget
brew install loongarch/homebrew-loong64/git

# 编辑器
brew install loongarch/homebrew-loong64/micro
brew install loongarch/homebrew-loong64/bat

# Shell & 终端工具
brew install loongarch/homebrew-loong64/fish
brew install loongarch/homebrew-loong64/tmux
brew install loongarch/homebrew-loong64/starship

# Rust 现代工具链
brew install loongarch/homebrew-loong64/fd
brew install loongarch/homebrew-loong64/ripgrep
brew install loongarch/homebrew-loong64/delta
brew install loongarch/homebrew-loong64/bottom

# 服务器软件
brew install loongarch/homebrew-loong64/redis
brew install loongarch/homebrew-loong64/nginx
brew install loongarch/homebrew-loong64/caddy
```

## 仓库结构

```
.
├── Formula/              # Homebrew 公式 (41个)
│   ├── curl.rb          # 网络传输工具
│   ├── wget.rb          # 文件下载工具
│   ├── redis.rb         # 数据库服务器
│   ├── nginx.rb         # Web 服务器
│   ├── caddy.rb         # 现代 Web 服务器
│   ├── micro.rb         # 终端编辑器
│   ├── fd.rb            # 文件搜索
│   ├── ripgrep.rb       # 快速 grep
│   ├── delta.rb         # Git 差异高亮
│   └── ...
├── scripts/             # 辅助脚本
│   ├── batch-build.sh   # 批量构建工具
│   └── build-bottles.sh # Bottle 构建脚本
├── docs/                # 文档
│   ├── BUILD_STATUS.md  # 完整构建状态
│   └── PHASE2-REPORT.md # Phase 2 进展报告
├── .github/workflows/   # CI/CD 配置
├── Makefile            # 便捷命令
└── README.md           # 本文件
```

## 当前状态 (Phase 2 完成 ✅)

### 已适配软件包: 82 个

#### 核心网络工具 (6)
- ✅ curl 8.19.0
- ✅ wget 1.25.0
- ✅ libnghttp2 1.68.1
- ✅ libssh2 1.11.1
- ✅ libidn2 2.3.8
- ✅ ca-certificates 2026-03-19

#### 开发工具链 (33)
- ✅ gettext 0.22.5
- ✅ perl 5.42.1
- ✅ vim 9.2
- ✅ cmake 4.3.1
- ✅ pcre2 10.47
- ✅ ninja 1.13.2
- ✅ ccache 4.11.2
- ✅ gdb 16.3
- ✅ binutils 2.46.0
- ✅ **Rust 现代工具** (13个): fd, ripgrep, bat, bandwhich, dust, tokei, hyperfine, bottom, gping, delta, choose, grex, xh, tre, gitui, broot

#### 服务器软件 (3)
- ✅ redis 7.4.2
- ✅ nginx 1.27.4
- ✅ caddy 2.11.2

#### 编辑器 (5)
- ✅ nano 8.7.1
- ✅ micro 2.0.15
- ✅ emacs 30.2
- ✅ bat 0.26.1

#### Shell & 终端 (5)
- ✅ fish 4.0.1
- ✅ zsh 5.9
- ✅ tmux 3.5a
- ✅ zoxide 0.9.7
- ✅ starship 1.22.1

#### 搜索工具 (4)
- ✅ fd 10.4.2
- ✅ fzf 0.60.3
- ✅ ripgrep 15.1.0
- ✅ exa 0.10.1

查看 [BUILD_STATUS.md](docs/BUILD_STATUS.md) 获取完整列表。

## 技术方案

### 1. 架构识别修复

修复 Homebrew 的 `hardware.rb`，使 `--build` 参数正确识别 loongarch64：

```ruby
cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
args << "--build=#{cpu}-unknown-linux-gnu"
```

### 2. GCC 15 兼容性修复

解决 GCC 15 引入的严格检查：

```bash
# Nginx HTTP/2 模块的字符串初始化警告
./configure --with-cc-opt="-Wno-unterminated-string-initialization"
```

### 3. 系统库复用

对于 gcc-15 编译困难的包，直接从 AOSC OS 系统复制：

```bash
mkdir -p $(brew --cellar)/gmp/6.3.0/{lib,include}
cp /usr/lib/libgmp* $(brew --cellar)/gmp/6.3.0/lib/
cp /usr/include/gmp*.h $(brew --cellar)/gmp/6.3.0/include/
brew link gmp
```

### 4. 精简依赖链

创建精简版 Formula，移除有问题的依赖：

- **curl** - 移除 brotli（gcc-15 不支持 `__attribute__((model("small")))`）
- **perl** - 禁用 DB_File 扩展（避免 berkeley-db@5 从源码构建）
- **wget** - 移除 pcre2、libpsl 等可选依赖
- **nginx** - 修复 GCC 15 字符串初始化警告

### 5. Bottle 构建 (实验性)

```bash
# 为单个包构建 bottle
./scripts/build-bottles.sh curl

# 批量构建
./scripts/build-bottles.sh --batch
```

## 使用限制

| 问题 | 影响包 | 解决方法 |
|------|--------|----------|
| brotli model 属性 | git, vim | 使用系统工具或精简 formula |
| autotools 架构识别 | jq, ripgrep | 需逐个 formula 修复 |
| gmp 严格检查 | 数学库 | 使用系统库 |
| GCC 15 字符串初始化 | nginx | 添加编译器标志 |

## 贡献指南

欢迎提交 PR 和 Issue！

### 提交 Formula

1. Fork 本仓库
2. 在 `Formula/` 目录添加 `.rb` 文件
3. 确保通过 `brew audit --strict` 检查
4. 提交 PR

## 路线图

- **Phase 1** ✅ (64 包) - 核心工具链
- **Phase 2** ✅ (82 包) - 服务器软件 + Rust 工具链
- **Phase 3** 🔄 (100+ 包) - 完整开发环境 + Bottle 分发

## 相关项目

- [Homebrew](https://github.com/Homebrew/brew) - macOS 和 Linux 的包管理器
- [AOSC OS](https://aosc.io) - 龙芯优化的 Linux 发行版
- [LoongArch Linux](https://github.com/loongarchlinux) - LoongArch Linux 支持

## 许可证

[MIT License](LICENSE)

## 致谢

感谢 AOSC OS 社区提供的系统库支持。
