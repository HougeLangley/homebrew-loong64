# Homebrew Loong64 Tap

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-loongarch64-red.svg)](https://github.com/loongarch/homebrew-loong64)
[![Homebrew](https://img.shields.io/badge/homebrew-5.0+-orange.svg)](https://brew.sh)

针对 LoongArch 64 (loong64) 架构优化的 Homebrew 第三方仓库。

## 简介

本仓库提供了专为 LoongArch 64 架构适配的 Homebrew Formulae，解决了在龙芯平台上构建软件时的常见兼容性问题，包括：

- **架构识别修复** - 修复 autotools `--build` 参数识别
- **系统库复用** - 复用 AOSC OS 等系统的预编译库
- **依赖精简** - 移除/替换在 loong64 上构建困难的依赖

## 快速开始

### 添加 Tap

```bash
brew tap loongarch/homebrew-loong64
```

### 安装软件包

```bash
# 安装 curl（移除 brotli 依赖）
brew install loongarch/homebrew-loong64/curl

# 安装 wget（精简依赖链）
brew install loongarch/homebrew-loong64/wget

# 安装 gettext（修复 json-c 依赖）
brew install loongarch/homebrew-loong64/gettext
```

## 仓库结构

```
.
├── Formula/              # Homebrew 公式
│   ├── curl.rb          # 网络传输工具
│   ├── wget.rb          # 文件下载工具
│   ├── gettext.rb       # 国际化库
│   ├── gmp.rb           # 大数运算库
│   ├── berkeley-db@5.rb # 数据库库
│   ├── perl.rb          # Perl 解释器
│   ├── vim.rb           # 文本编辑器
│   ├── git.rb           # 版本控制
│   ├── jq.rb            # JSON 处理
│   └── unzip.rb         # 解压工具
├── patches/             # 补丁文件
├── scripts/             # 辅助脚本
├── docs/                # 文档
└── .github/workflows/   # CI 配置
```

## 当前状态

### 已适配软件包 (45个)

#### 核心网络工具
- ✅ curl 8.19.0
- ✅ wget 1.25.0
- ✅ libnghttp2 1.68.1
- ✅ libssh2 1.11.1
- ✅ libidn2 2.3.8

#### 开发工具链
- ✅ gettext 0.22.5
- ✅ perl 5.42.1
- ✅ vim 9.2
- ✅ cmake 4.3.1
- ✅ pcre2 10.47

#### 系统库
- ✅ gmp 6.3.0 (系统库)
- ✅ berkeley-db@5 5.3.28 (系统库)
- ✅ json-c 0.18
- ✅ acl 2.3.2
- ✅ attr 2.5.2

查看 [BUILD_STATUS.md](docs/BUILD_STATUS.md) 获取完整列表。

## 技术方案

### 1. 架构识别修复

修复 Homebrew 的 `hardware.rb`，使 `--build` 参数正确识别 loongarch64：

```ruby
cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
args << "--build=#{cpu}-unknown-linux-gnu"
```

### 2. 系统库复用

对于 gcc-15 编译困难的包（如 gmp、berkeley-db@5），直接从 AOSC OS 系统复制：

```bash
mkdir -p $(brew --cellar)/gmp/6.3.0/{lib,include}
cp /usr/lib/libgmp* $(brew --cellar)/gmp/6.3.0/lib/
cp /usr/include/gmp*.h $(brew --cellar)/gmp/6.3.0/include/
brew link gmp
```

### 3. 精简依赖链

创建精简版 Formula，移除有问题的依赖：

- **curl** - 移除 brotli（gcc-15 不支持 `__attribute__((model("small")))`）
- **perl** - 禁用 DB_File 扩展（避免 berkeley-db@5 从源码构建）
- **wget** - 移除 pcre2、libpsl 等可选依赖

## 使用限制

| 问题 | 影响包 | 解决方法 |
|------|--------|----------|
| brotli model 属性 | git, vim | 使用系统工具或精简 formula |
| autotools 架构识别 | jq, ripgrep | 需逐个 formula 修复 |
| gmp 严格检查 | 数学库 | 使用系统库 |

## 贡献指南

欢迎提交 PR 和 Issue！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

### 提交 Formula

1. Fork 本仓库
2. 在 `Formula/` 目录添加 `.rb` 文件
3. 确保通过 `brew audit --strict` 检查
4. 提交 PR

## 相关项目

- [Homebrew](https://github.com/Homebrew/brew) - macOS 和 Linux 的包管理器
- [AOSC OS](https://aosc.io) - 龙芯优化的 Linux 发行版
- [LoongArch Linux](https://github.com/loongarchlinux) - LoongArch Linux 支持

## 许可证

[MIT License](LICENSE)

## 致谢

感谢 AOSC OS 社区提供的系统库支持。
