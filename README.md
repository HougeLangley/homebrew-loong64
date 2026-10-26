# homebrew-loong64

[![arch](https://img.shields.io/badge/arch-loongarch64-blue)](https://loongson.cn)
[![packages](https://img.shields.io/badge/packages-43-brightgreen)](#-可用软件包)
[![site](https://img.shields.io/badge/site-homebrewloongarch64.site-0a5)](https://homebrewloongarch64.site)
[![license](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE)

> **LoongArch（龙架构，`loongarch64`）的 Homebrew tap 与预编译 bottle 源。**
>
> 上游 Homebrew 目前只支持 macOS 与 x86_64/aarch64 Linux。本项目为龙架构提供三样东西：
> **可用的 tap**、**预编译好的 bottle**、以及**homebrew-core 的独立镜像**。

---

## 目录

- [为什么需要这个项目](#为什么需要这个项目)
- [快速开始](#快速开始)
- [可用软件包](#-可用软件包)
- [镜像与加速](#镜像与加速)
- [工作原理](#工作原理)
- [安全与校验](#安全与校验)
- [常见问题](#常见问题)
- [参与贡献](#参与贡献)
- [路线图](#路线图)
- [许可证与免责声明](#许可证与免责声明)

---

## 为什么需要这个项目

LoongArch 是独立于 x86/ARM 的指令集架构。Homebrew 的 formula 大量依赖 macOS/Linux 上的
预编译 bottle 与架构假设，官方 CI 也没有 loongarch64 runner，所以：

- 官方 `brew install` 在龙架构上没有可用的二进制包；
- 即使从源码编译，很多 formula 的 `depends_on` 与构建脚本也假定 x86/ARM；
- 国内访问 GitHub 与 `ghcr.io`（官方 bottle 托管）速度不稳定。

本项目把这条链路补上：**在真实的龙芯机器（3A6000）上逐个编译、校验、签名、发布**，
并提供国内可直接访问的镜像。

## 快速开始

### 方式 A：已有 loongarch64 版 Homebrew

如果你自行构建了可运行在 loongarch64 的 Homebrew（或使用了社区移植版本），直接添加本 tap：

```bash
brew tap HougeLangley/loong64
brew install tree          # 从本项目的 bottle 安装
brew info tree             # 查看版本与来源
```

bottle 由 tap 中的 `url` 指向本项目的站点，`sha256` 与站点索引一致，`brew` 会自行校验。

### 方式 B：不安装 Homebrew（推荐普通用户）

项目提供了一个零依赖的安装脚本，只用到 `curl` / `sha256sum` / `tar`：

```bash
# 安装到 /usr/local/bin（需要写权限，或加 sudo 后指定 --prefix）
curl -fsSL https://homebrewloongarch64.site/get.sh | sudo sh -s tree

# 安装到自定义前缀
curl -fsSL https://homebrewloongarch64.site/get.sh | sh -s tree --prefix ~/.local
```

脚本会：读取索引 → 下载对应 bottle → 校验 SHA-256 → 解包 → 把可执行文件放进 `<prefix>/bin`。

也可以完全手动：

```bash
curl -fsSL https://homebrewloongarch64.site/brew/index.json | jq '.formulae[] | select(.name=="tree")'
curl -LO https://homebrewloongarch64.site/brew/bottles/tree--2.3.2.loongarch64.bottle.tar.gz
sha256sum tree--2.3.2.loongarch64.bottle.tar.gz     # 与索引中的 sha256 比对
tar xzf tree--2.3.2.loongarch64.bottle.tar.gz -C /usr/local/bin
```

### 方式 C：作为 Formula 引用

```ruby
# 在你自己的 tap 里
class Foo < Formula
  url "https://homebrewloongarch64.site/brew/bottles/foo--1.0.0.loongarch64.bottle.tar.gz"
  sha256 "<从 index.json 取>"
  def install
    bin.install "foo"
  end
end
```

## 可用软件包

> 本表由发布流水线自动生成（2026-10-26 21:30 (UTC+8)），与站点索引 `index.json` 实时同源。

| 包 | 版本 | 大小 | SHA-256（前 12 位） | 下载 |
|---|---|---|---|---|
| **atuin** | 18.24.2 | 19 MiB | `bf7a62f6ab90` | [bottle](https://homebrewloongarch64.site/brew/bottles/atuin--18.24.2.loongarch64.bottle.tar.gz) |
| **bandwhich** | 0.23.1 | 1.4 MiB | `9ee90b9a5ff4` | [bottle](https://homebrewloongarch64.site/brew/bottles/bandwhich--0.23.1.loongarch64.bottle.tar.gz) |
| **bat** | 0.26.1 | 4.3 MiB | `a652540e6b66` | [bottle](https://homebrewloongarch64.site/brew/bottles/bat--0.26.1.loongarch64.bottle.tar.gz) |
| **choose** | 1.3.7 | 878 KiB | `471669f5c29f` | [bottle](https://homebrewloongarch64.site/brew/bottles/choose--1.3.7.loongarch64.bottle.tar.gz) |
| **curl** | 8.23.0 | 3.4 KiB | `160fc37a6f57` | [bottle](https://homebrewloongarch64.site/brew/bottles/curl--8.23.0.loongarch64.bottle.tar.gz) |
| **delta** | 0.20.1 | 3.1 MiB | `6fb566f53a0b` | [bottle](https://homebrewloongarch64.site/brew/bottles/delta--0.20.1.loongarch64.bottle.tar.gz) |
| **direnv** | 2.38.2 | 3.4 MiB | `21e86279a5a0` | [bottle](https://homebrewloongarch64.site/brew/bottles/direnv--2.38.2.loongarch64.bottle.tar.gz) |
| **dua** | 2.46.0 | 2.3 MiB | `73ed3c0d81b1` | [bottle](https://homebrewloongarch64.site/brew/bottles/dua--2.46.0.loongarch64.bottle.tar.gz) |
| **duf** | 0.9.1 | 1.5 MiB | `04e99606991a` | [bottle](https://homebrewloongarch64.site/brew/bottles/duf--0.9.1.loongarch64.bottle.tar.gz) |
| **dust** | 1.2.6 | 1.2 MiB | `33cf77e6e82c` | [bottle](https://homebrewloongarch64.site/brew/bottles/dust--1.2.6.loongarch64.bottle.tar.gz) |
| **dysk** | 3.8.1 | 1.1 MiB | `12f37c07382d` | [bottle](https://homebrewloongarch64.site/brew/bottles/dysk--3.8.1.loongarch64.bottle.tar.gz) |
| **eza** | 0.23.5 | 1.2 MiB | `51e16f7772b6` | [bottle](https://homebrewloongarch64.site/brew/bottles/eza--0.23.5.loongarch64.bottle.tar.gz) |
| **fd** | 10.5.0 | 1.3 MiB | `c8ce26b0e755` | [bottle](https://homebrewloongarch64.site/brew/bottles/fd--10.5.0.loongarch64.bottle.tar.gz) |
| **fzf** | 0.74.5 | 2.1 MiB | `adcc7a15e53f` | [bottle](https://homebrewloongarch64.site/brew/bottles/fzf--0.74.5.loongarch64.bottle.tar.gz) |
| **git-cliff** | 2.14.2 | 5.8 MiB | `1112e148366f` | [bottle](https://homebrewloongarch64.site/brew/bottles/git-cliff--2.14.2.loongarch64.bottle.tar.gz) |
| **hello** | 1.0.0 | 155 B | `e27343330553` | [bottle](https://homebrewloongarch64.site/brew/bottles/hello--1.0.0.loongarch64.bottle.tar.gz) |
| **hexyl** | 0.17.0 | 525 KiB | `a545292847af` | [bottle](https://homebrewloongarch64.site/brew/bottles/hexyl--0.17.0.loongarch64.bottle.tar.gz) |
| **hyperfine** | 2.0.0 | 685 KiB | `af23c9b3812b` | [bottle](https://homebrewloongarch64.site/brew/bottles/hyperfine--2.0.0.loongarch64.bottle.tar.gz) |
| **iperf3** | 3.22 | 85 KiB | `c7b39b6a9c7d` | [bottle](https://homebrewloongarch64.site/brew/bottles/iperf3--3.22.loongarch64.bottle.tar.gz) |
| **jq** | 1.8.2 | 376 KiB | `acb6139ce84a` | [bottle](https://homebrewloongarch64.site/brew/bottles/jq--1.8.2.loongarch64.bottle.tar.gz) |
| **just** | 1.59.0 | 2.3 MiB | `f8911a872106` | [bottle](https://homebrewloongarch64.site/brew/bottles/just--1.59.0.loongarch64.bottle.tar.gz) |
| **lazygit** | 0.66.2 | 6.7 MiB | `74f1655fbf76` | [bottle](https://homebrewloongarch64.site/brew/bottles/lazygit--0.66.2.loongarch64.bottle.tar.gz) |
| **less** | 710 | 138 KiB | `67924aa8a469` | [bottle](https://homebrewloongarch64.site/brew/bottles/less--710.loongarch64.bottle.tar.gz) |
| **lz4** | 1.10.0 | 178 KiB | `be4b4c6ab61d` | [bottle](https://homebrewloongarch64.site/brew/bottles/lz4--1.10.0.loongarch64.bottle.tar.gz) |
| **mcfly** | 0.9.4 | 2.3 MiB | `6f03b3d016e3` | [bottle](https://homebrewloongarch64.site/brew/bottles/mcfly--0.9.4.loongarch64.bottle.tar.gz) |
| **mtr** | 0.96 | 52 KiB | `6606186e4f3a` | [bottle](https://homebrewloongarch64.site/brew/bottles/mtr--0.96.loongarch64.bottle.tar.gz) |
| **nano** | 9.3 | 186 KiB | `dbd2a7d0d3b9` | [bottle](https://homebrewloongarch64.site/brew/bottles/nano--9.3.loongarch64.bottle.tar.gz) |
| **pkgconf** | 3.0.10 | 3.2 KiB | `4aac6a85a57a` | [bottle](https://homebrewloongarch64.site/brew/bottles/pkgconf--3.0.10.loongarch64.bottle.tar.gz) |
| **procs** | 0.14.12 | 2.5 MiB | `382f9c956cf6` | [bottle](https://homebrewloongarch64.site/brew/bottles/procs--0.14.12.loongarch64.bottle.tar.gz) |
| **pv** | 1.12.0 | 74 KiB | `8ab20b94f693` | [bottle](https://homebrewloongarch64.site/brew/bottles/pv--1.12.0.loongarch64.bottle.tar.gz) |
| **ripgrep** | 15.2.0 | 1.8 MiB | `ba4970209ed6` | [bottle](https://homebrewloongarch64.site/brew/bottles/ripgrep--15.2.0.loongarch64.bottle.tar.gz) |
| **sd** | 1.1.0 | 962 KiB | `626242bdf11d` | [bottle](https://homebrewloongarch64.site/brew/bottles/sd--1.1.0.loongarch64.bottle.tar.gz) |
| **sqlite** | 3.54.1 | 980 KiB | `23101a77dfb2` | [bottle](https://homebrewloongarch64.site/brew/bottles/sqlite--3.54.1.loongarch64.bottle.tar.gz) |
| **starship** | 1.27.0 | 5.2 MiB | `5cc3e8f292e7` | [bottle](https://homebrewloongarch64.site/brew/bottles/starship--1.27.0.loongarch64.bottle.tar.gz) |
| **tmux** | 3.8 | 619 KiB | `f37ac724d7ae` | [bottle](https://homebrewloongarch64.site/brew/bottles/tmux--3.8.loongarch64.bottle.tar.gz) |
| **tokei** | 15.0.0 | 1.5 MiB | `7fed8841f0d2` | [bottle](https://homebrewloongarch64.site/brew/bottles/tokei--15.0.0.loongarch64.bottle.tar.gz) |
| **tree** | 2.3.2 | 82 KiB | `00e78475fdf5` | [bottle](https://homebrewloongarch64.site/brew/bottles/tree--2.3.2.loongarch64.bottle.tar.gz) |
| **typos** | 1.51.1 | 4.3 MiB | `59d761210834` | [bottle](https://homebrewloongarch64.site/brew/bottles/typos--1.51.1.loongarch64.bottle.tar.gz) |
| **watchexec** | 2.8.0 | 4.4 MiB | `9a4a5aff0366` | [bottle](https://homebrewloongarch64.site/brew/bottles/watchexec--2.8.0.loongarch64.bottle.tar.gz) |
| **xh** | 0.26.3 | 4.1 MiB | `d7986d25b25a` | [bottle](https://homebrewloongarch64.site/brew/bottles/xh--0.26.3.loongarch64.bottle.tar.gz) |
| **yq** | 4.54.1 | 5.1 MiB | `9f8becb5a18c` | [bottle](https://homebrewloongarch64.site/brew/bottles/yq--4.54.1.loongarch64.bottle.tar.gz) |
| **zoxide** | 0.10.0 | 551 KiB | `78054be448cc` | [bottle](https://homebrewloongarch64.site/brew/bottles/zoxide--0.10.0.loongarch64.bottle.tar.gz) |
| **zstd** | 1.5.7 | 566 KiB | `44068455a81b` | [bottle](https://homebrewloongarch64.site/brew/bottles/zstd--1.5.7.loongarch64.bottle.tar.gz) |

## 镜像与加速

本站同时提供两个上游镜像，适合中国大陆网络环境：

| 用途 | 地址 | 更新频率 |
|---|---|---|
| `homebrew-core` 浅镜像 | `https://homebrewloongarch64.site/git/homebrew-core.git` | 每 6 小时 |
| 官方 formulae JSON 快照 | `https://homebrewloongarch64.site/brew/api/formula.json` | 每 6 小时 |
| 本 tap 的 git 源 | `https://homebrewloongarch64.site/git/homebrew-loong64.git` | 每次发布 |

```bash
# 用镜像克隆 homebrew-core（浅历史，约 12 MB）
git clone --depth 1 https://homebrewloongarch64.site/git/homebrew-core.git

# 或者只取元数据
curl -fsSL https://homebrewloongarch64.site/brew/api/formula.json -o formula.json
```

## 工作原理

```
ci/recipes/<pkg>.sh        每个包的构建配方（下载源码 → 编译 → strip）
        │
        ▼
bottle-ci.service          队列驱动，串行构建（龙芯机器性能有限，绝不并行）
        │
        ▼
brew-make-bottle.sh        打包 bottle + 回填 formula 的 sha256
        │
        ▼
gen-docs.py                重新生成本 README 的包表 + 站点主页的包区块
        │
        ├──► git push  → GitHub（本仓库，即 tap 源码）
        ├──► git push  → 站点裸仓库（/git/homebrew-loong64.git）
        └──► rsync     → https://homebrewloongarch64.site（bottle + 索引）
                                   │
                                   ▼
                          HTTPS 冒烟检查（签名 / 索引 / 下载）
```

一次 `bottle` 构建完成后，上述链路自动跑完，不需要手工改文档或主页。

## 安全与校验

- **不修改上游源码**：每个包都从上游 tag 构建，配方文件（`ci/recipes/`）公开可查。
- **SHA-256 校验**：`index.json` 中每个 bottle 都有 `sha256` 与 `size`。
- **仓库签名**：APT 源与本 tap 同源发布，`Release/InRelease` 由项目密钥签名。
- **可复现**：构建机器、编译器版本、配方都记录在 [构建机说明](https://homebrewloongarch64.site)。

```bash
# 校验下载的 bottle
curl -fsSL https://homebrewloongarch64.site/brew/index.json \
  | jq -r '.formulae[] | select(.name=="tree") | .bottles[0].sha256'
```

## 常见问题

**Q：`brew install` 报 “No available formula with the name …”？**
确认 `brew tap HougeLangley/loong64` 成功，并且你的 `brew` 运行在 loongarch64 上（`brew config` 里的 `CPU` 字段）。

**Q：能安装到任意 prefix 吗？**
bottle 内的可执行文件是静态链接或只依赖 glibc，可以直接放到任意目录。用 `get.sh --prefix` 即可。

**Q：glibc 版本要求？**
构建机使用 AOSC OS 14 / glibc 2.44。C 程序通常要求 glibc ≥ 2.34；纯 Rust/Go 二进制基本无依赖。

**Q：为什么包数量不多？**
构建机是一台龙芯 3A6000 笔记本，采用**串行**构建（一次一个包），保证机器稳定。
新包通过队列提交，见下文「参与贡献」。

**Q：如何卸载？**
用 `brew uninstall <formula>`；用 `get.sh` 装的，删除 `<prefix>/bin/<name>` 即可。

**Q：会跟随上游更新吗？**
每个配方固定上游 tag，新版本需要更新配方；`homebrew-core` 与官方 JSON 每 6 小时自动同步。

**Q：能提交新包吗？**
可以，见下一节。

## 参与贡献

1. 新包请求：开 Issue，附上游仓库与许可证。
2. 提交配方：在 `ci/recipes/` 添加 `<name>.sh`（参考 `lz4.sh`），CI 会按队列构建。
3. 发现问题：开 Issue 并附 `brew install` 或 `get.sh` 的完整输出。

配方最小示例：

```bash
#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "$0")/.." && pwd)/lib.sh"

NAME=foo
VER=1.2.3
WORK="$CI_WORK/$NAME-$VER"

fetch "https://github.com/acme/foo/archive/refs/tags/v$VER.tar.gz" "$WORK"
( cd "$WORK" && ./configure --prefix=/usr && make -j"$CI_JOBS" )

strip_copy "$WORK/foo" "$CI_STAGE/foo"
publish foo "$VER" "$CI_STAGE/foo" "Foo does something useful"
```

## 路线图

- [x] bottle 构建 CI（队列 + 串行）
- [x] 站点搜索页
- [x] homebrew-core 镜像
- [ ] loongarch64 Homebrew 本体移植（Ruby 运行时 + 架构检测）
- [ ] 自动化新版本检测（跟随上游 tag）
- [ ] 更多基础包（网络、开发工具链）

## 许可证与免责声明

本项目自身代码以 MIT 发布；每个软件包的许可证见各自上游。
二进制按「原样」提供，不附带任何担保。使用前请自行评估。

---

<sub>本站与仓库内容由发布流水线自动同步；仓库地址
[github.com/HougeLangley/homebrew-loong64](https://github.com/HougeLangley/homebrew-loong64)，
站点 [homebrewloongarch64.site](https://homebrewloongarch64.site)。</sub>
