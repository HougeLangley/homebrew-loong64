# homebrew-loong64

[![arch](https://img.shields.io/badge/arch-loongarch64-blue)](https://loongson.cn)
[![packages](https://img.shields.io/badge/packages-205-brightgreen)](#-可用软件包)
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

> 本表由发布流水线自动生成（2026-10-27 19:25 (UTC+8)），与站点索引 `index.json` 实时同源。

| 包 | 版本 | 大小 | SHA-256（前 12 位） | 下载 |
|---|---|---|---|---|
| **photoview** | 2.4.0 | 1.4 MiB | `e649612afe75` | [bottle](https://homebrewloongarch64.site/brew/bottles/photoview--2.4.0.loongarch64.bottle.tar.gz) |
| **phrase-cli** | 2.71.0 | 4.5 MiB | `176183e87848` | [bottle](https://homebrewloongarch64.site/brew/bottles/phrase-cli--2.71.0.loongarch64.bottle.tar.gz) |
| **picoclaw** | 0.3.1 | 3.8 MiB | `1743a337f4fd` | [bottle](https://homebrewloongarch64.site/brew/bottles/picoclaw--0.3.1.loongarch64.bottle.tar.gz) |
| **piknik** | 0.10.2 | 1.3 MiB | `aed5e335700a` | [bottle](https://homebrewloongarch64.site/brew/bottles/piknik--0.10.2.loongarch64.bottle.tar.gz) |
| **piko** | 0.10.1 | 4.0 MiB | `ccbf3e8963ea` | [bottle](https://homebrewloongarch64.site/brew/bottles/piko--0.10.1.loongarch64.bottle.tar.gz) |
| **pinact** | 5.0.2 | 2.7 MiB | `d01107afc4b9` | [bottle](https://homebrewloongarch64.site/brew/bottles/pinact--5.0.2.loongarch64.bottle.tar.gz) |
| **pint** | 0.89.4 | 9.8 MiB | `26f1ed0b0339` | [bottle](https://homebrewloongarch64.site/brew/bottles/pint--0.89.4.loongarch64.bottle.tar.gz) |
| **pipeline** | 1.17.1 | 21 MiB | `a21b343b8540` | [bottle](https://homebrewloongarch64.site/brew/bottles/pipeline--1.17.1.loongarch64.bottle.tar.gz) |
| **pivit** | 0.9.3 | 2.5 MiB | `be65f84a6c9f` | [bottle](https://homebrewloongarch64.site/brew/bottles/pivit--0.9.3.loongarch64.bottle.tar.gz) |
| **pixiv-cli** | 1.2.1 | 26 MiB | `b21f588e7338` | [bottle](https://homebrewloongarch64.site/brew/bottles/pixiv-cli--1.2.1.loongarch64.bottle.tar.gz) |
| **pixivbiu** | 3.1.6 | 2.3 MiB | `e4fe7635209a` | [bottle](https://homebrewloongarch64.site/brew/bottles/pixivbiu--3.1.6.loongarch64.bottle.tar.gz) |
| **pixlet** | 0.55.0 | 3.4 MiB | `4672b6baf3f6` | [bottle](https://homebrewloongarch64.site/brew/bottles/pixlet--0.55.0.loongarch64.bottle.tar.gz) |
| **pjs** | 0.1.0 | 4.0 MiB | `4df4a4c9d76e` | [bottle](https://homebrewloongarch64.site/brew/bottles/pjs--0.1.0.loongarch64.bottle.tar.gz) |
| **pkg-config-wrapper** | 0.2.13 | 3.8 MiB | `c87f102ad2ad` | [bottle](https://homebrewloongarch64.site/brew/bottles/pkg-config-wrapper--0.2.13.loongarch64.bottle.tar.gz) |
| **pkgconf** | 3.0.10 | 3.2 KiB | `4aac6a85a57a` | [bottle](https://homebrewloongarch64.site/brew/bottles/pkgconf--3.0.10.loongarch64.bottle.tar.gz) |
| **pkgsite** | 0.6.0 | 14 MiB | `8f59fe10ff65` | [bottle](https://homebrewloongarch64.site/brew/bottles/pkgsite--0.6.0.loongarch64.bottle.tar.gz) |
| **plakar** | 1.1.8 | 20 MiB | `8f9d74800205` | [bottle](https://homebrewloongarch64.site/brew/bottles/plakar--1.1.8.loongarch64.bottle.tar.gz) |
| **plow** | 1.4.0 | 5.5 MiB | `964327803a53` | [bottle](https://homebrewloongarch64.site/brew/bottles/plow--1.4.0.loongarch64.bottle.tar.gz) |
| **pluto** | 5.24.4 | 9.1 MiB | `406eba3632c6` | [bottle](https://homebrewloongarch64.site/brew/bottles/pluto--5.24.4.loongarch64.bottle.tar.gz) |
| **pmg** | 0.33.0 | 5.7 MiB | `00ca7b7cc16e` | [bottle](https://homebrewloongarch64.site/brew/bottles/pmg--0.33.0.loongarch64.bottle.tar.gz) |
| **pmtiles** | 1.31.2 | 16 MiB | `15cadd8d1460` | [bottle](https://homebrewloongarch64.site/brew/bottles/pmtiles--1.31.2.loongarch64.bottle.tar.gz) |
| **pocket-id** | 2.19.1 | 2.6 MiB | `3d9c55d33cff` | [bottle](https://homebrewloongarch64.site/brew/bottles/pocket-id--2.19.1.loongarch64.bottle.tar.gz) |
| **pocketbase** | 0.40.6 | 11 MiB | `85c5b54f2b08` | [bottle](https://homebrewloongarch64.site/brew/bottles/pocketbase--0.40.6.loongarch64.bottle.tar.gz) |
| **podinfo** | 6.17.0 | 5.0 MiB | `1301bd607584` | [bottle](https://homebrewloongarch64.site/brew/bottles/podinfo--6.17.0.loongarch64.bottle.tar.gz) |
| **polaris** | 10.2.5 | 14 MiB | `73fe2ca9af1f` | [bottle](https://homebrewloongarch64.site/brew/bottles/polaris--10.2.5.loongarch64.bottle.tar.gz) |
| **policy-engine** | 1.1.7 | 19 MiB | `59bcc878e9f7` | [bottle](https://homebrewloongarch64.site/brew/bottles/policy-engine--1.1.7.loongarch64.bottle.tar.gz) |
| **pomo** | 1.2.1 | 26 MiB | `354e0767b612` | [bottle](https://homebrewloongarch64.site/brew/bottles/pomo--1.2.1.loongarch64.bottle.tar.gz) |
| **popeye** | 0.22.1 | 4.6 MiB | `9ffcc0c899cf` | [bottle](https://homebrewloongarch64.site/brew/bottles/popeye--0.22.1.loongarch64.bottle.tar.gz) |
| **porter** | 1.6.1 | 4.0 MiB | `dfda2c8ef688` | [bottle](https://homebrewloongarch64.site/brew/bottles/porter--1.6.1.loongarch64.bottle.tar.gz) |
| **portop** | 0.3.1 | 3.8 MiB | `fdeb51556934` | [bottle](https://homebrewloongarch64.site/brew/bottles/portop--0.3.1.loongarch64.bottle.tar.gz) |
| **postgresparser** | 1.3.2 | 2.0 MiB | `ba5f679fa4f3` | [bottle](https://homebrewloongarch64.site/brew/bottles/postgresparser--1.3.2.loongarch64.bottle.tar.gz) |
| **pouch** | 1.3.1 | 2.8 MiB | `7ae83625f48f` | [bottle](https://homebrewloongarch64.site/brew/bottles/pouch--1.3.1.loongarch64.bottle.tar.gz) |
| **poutine** | 1.1.6 | 15 MiB | `5d11babb6634` | [bottle](https://homebrewloongarch64.site/brew/bottles/poutine--1.1.6.loongarch64.bottle.tar.gz) |
| **powerline-go** | 1.26 | 1.6 MiB | `72c3b69b141d` | [bottle](https://homebrewloongarch64.site/brew/bottles/powerline-go--1.26.loongarch64.bottle.tar.gz) |
| **powerman-dockerize** | 0.25.4 | 3.9 MiB | `5083d7b35712` | [bottle](https://homebrewloongarch64.site/brew/bottles/powerman-dockerize--0.25.4.loongarch64.bottle.tar.gz) |
| **prest** | 2.5.2 | 1.7 MiB | `ae6165bdc2b1` | [bottle](https://homebrewloongarch64.site/brew/bottles/prest--2.5.2.loongarch64.bottle.tar.gz) |
| **prestd** | 2.5.2 | 1.7 MiB | `44782215d847` | [bottle](https://homebrewloongarch64.site/brew/bottles/prestd--2.5.2.loongarch64.bottle.tar.gz) |
| **pretender** | 1.4.1 | 2.5 MiB | `ffa0c162a798` | [bottle](https://homebrewloongarch64.site/brew/bottles/pretender--1.4.1.loongarch64.bottle.tar.gz) |
| **privatebin-cli** | 2.2.1 | 563 B | `584454940f60` | [bottle](https://homebrewloongarch64.site/brew/bottles/privatebin-cli--2.2.1.loongarch64.bottle.tar.gz) |
| **prm** | 3.6.4 | 3.8 MiB | `dcf7ae1e57e4` | [bottle](https://homebrewloongarch64.site/brew/bottles/prm--3.6.4.loongarch64.bottle.tar.gz) |
| **process-compose** | 1.124.0 | 15 MiB | `e0fdbf2834b4` | [bottle](https://homebrewloongarch64.site/brew/bottles/process-compose--1.124.0.loongarch64.bottle.tar.gz) |
| **procoder** | 3.9.2 | 6.4 MiB | `c1517530b543` | [bottle](https://homebrewloongarch64.site/brew/bottles/procoder--3.9.2.loongarch64.bottle.tar.gz) |
| **procs** | 0.14.12 | 2.5 MiB | `382f9c956cf6` | [bottle](https://homebrewloongarch64.site/brew/bottles/procs--0.14.12.loongarch64.bottle.tar.gz) |
| **progressbar** | 3.19.1 | 1.7 MiB | `f9d88b1eda6d` | [bottle](https://homebrewloongarch64.site/brew/bottles/progressbar--3.19.1.loongarch64.bottle.tar.gz) |
| **proji** | 0.20.0 | 14 MiB | `4b079dc65124` | [bottle](https://homebrewloongarch64.site/brew/bottles/proji--0.20.0.loongarch64.bottle.tar.gz) |
| **prometheus** | 3.15.1 | 26 MiB | `9163b76bdc6e` | [bottle](https://homebrewloongarch64.site/brew/bottles/prometheus--3.15.1.loongarch64.bottle.tar.gz) |
| **prometheus-msteams** | 1.5.4 | 9.6 MiB | `0c2e6ed072cd` | [bottle](https://homebrewloongarch64.site/brew/bottles/prometheus-msteams--1.5.4.loongarch64.bottle.tar.gz) |
| **prometheus-operator** | 0.94.2 | 12 MiB | `5d430d7ab47b` | [bottle](https://homebrewloongarch64.site/brew/bottles/prometheus-operator--0.94.2.loongarch64.bottle.tar.gz) |
| **prompt** | 0.9.3 | 2.5 MiB | `40016be58c4e` | [bottle](https://homebrewloongarch64.site/brew/bottles/prompt--0.9.3.loongarch64.bottle.tar.gz) |
| **promtail** | 3.7.9 | 21 MiB | `96ea94f6078d` | [bottle](https://homebrewloongarch64.site/brew/bottles/promtail--3.7.9.loongarch64.bottle.tar.gz) |
| **promxy** | 0.0.97 | 29 MiB | `1757eba848ab` | [bottle](https://homebrewloongarch64.site/brew/bottles/promxy--0.0.97.loongarch64.bottle.tar.gz) |
| **protoc-gen-go-grpc** | 1.84.0 | 4.2 MiB | `649f4e0d50d1` | [bottle](https://homebrewloongarch64.site/brew/bottles/protoc-gen-go-grpc--1.84.0.loongarch64.bottle.tar.gz) |
| **proxify** | 0.0.16 | 4.8 MiB | `775e5bab8d30` | [bottle](https://homebrewloongarch64.site/brew/bottles/proxify--0.0.16.loongarch64.bottle.tar.gz) |
| **pscale** | 0.348.0 | 11 MiB | `0b4483ac4a37` | [bottle](https://homebrewloongarch64.site/brew/bottles/pscale--0.348.0.loongarch64.bottle.tar.gz) |
| **pspy** | 1.2.1 | 26 MiB | `706f99d49531` | [bottle](https://homebrewloongarch64.site/brew/bottles/pspy--1.2.1.loongarch64.bottle.tar.gz) |
| **pterm** | 0.12.84 | 902 KiB | `16b053cc50c5` | [bottle](https://homebrewloongarch64.site/brew/bottles/pterm--0.12.84.loongarch64.bottle.tar.gz) |
| **pug** | 0.6.5 | 6.2 MiB | `0b02cb05d872` | [bottle](https://homebrewloongarch64.site/brew/bottles/pug--0.6.5.loongarch64.bottle.tar.gz) |
| **pulsarctl** | 4.2.5.2 | 5.0 MiB | `28fed041208c` | [bottle](https://homebrewloongarch64.site/brew/bottles/pulsarctl--4.2.5.2.loongarch64.bottle.tar.gz) |
| **pulse** | 6.6.0 | 1.9 MiB | `38b346beb69c` | [bottle](https://homebrewloongarch64.site/brew/bottles/pulse--6.6.0.loongarch64.bottle.tar.gz) |
| **pulumictl** | 0.0.50 | 13 MiB | `dae771155922` | [bottle](https://homebrewloongarch64.site/brew/bottles/pulumictl--0.0.50.loongarch64.bottle.tar.gz) |

> 仅显示前 60 个，共 **205** 个。完整列表见 [搜索页](https://homebrewloongarch64.site/brew/search.html)。

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

## 已知限制

以下是 loongarch64 平台上确认无法直接构建（或需要额外处理）的软件，均已记录在案：

| 软件 | 原因 | 现状 |
|---|---|---|
| `ctop` | 依赖树停留在 2021 年（runc 旧 API 路径已被移除），无 loongarch64 支持 | 未收录（上游废弃） |
| `uv` | 依赖 `linux_raw_sys` 未定义 loongarch64 的 `FIEMAP_*` ioctl 常量 | 未收录（上游问题） |
| `jless` 0.9 | `Cargo.lock` 锁定的 `libc`/`nix` 与当前工具链不兼容，上游无新版 | 未收录（上游问题） |
| LuaJIT | 无 loongarch64 后端 | `neovim` 改用系统 Lua 5.1 构建（`PREFER_LUA=ON`） |
| `helix` | 自动拉取的某个 tree-sitter 语法仓库已失效 | 关闭自动语法拉取构建，运行时可 `hx --grammar fetch` |

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
