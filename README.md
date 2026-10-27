# homebrew-loong64

[![arch](https://img.shields.io/badge/arch-loongarch64-blue)](https://loongson.cn)
[![packages](https://img.shields.io/badge/packages-1045-brightgreen)](#-可用软件包)
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

> 本表由发布流水线自动生成（2026-10-27 19:15 (UTC+8)），与站点索引 `index.json` 实时同源。

| 包 | 版本 | 大小 | SHA-256（前 12 位） | 下载 |
|---|---|---|---|---|
| **curl2httpie** | 1.9 | 1.9 MiB | `022cf845c974` | [bottle](https://homebrewloongarch64.site/brew/bottles/curl2httpie--1.9.loongarch64.bottle.tar.gz) |
| **curlie** | 1.8.2 | 1.3 MiB | `30c848502dda` | [bottle](https://homebrewloongarch64.site/brew/bottles/curlie--1.8.2.loongarch64.bottle.tar.gz) |
| **cute** | 0.1.24 | 11 MiB | `8422bf919865` | [bottle](https://homebrewloongarch64.site/brew/bottles/cute--0.1.24.loongarch64.bottle.tar.gz) |
| **cw** | 4.1.3 | 4.1 MiB | `5b65e85bf8b6` | [bottle](https://homebrewloongarch64.site/brew/bottles/cw--4.1.3.loongarch64.bottle.tar.gz) |
| **cwai** | 0.1.1 | 1.1 MiB | `8b11da380555` | [bottle](https://homebrewloongarch64.site/brew/bottles/cwai--0.1.1.loongarch64.bottle.tar.gz) |
| **cyclonedx-gomod** | 1.12.0 | 845 KiB | `0b10373af229` | [bottle](https://homebrewloongarch64.site/brew/bottles/cyclonedx-gomod--1.12.0.loongarch64.bottle.tar.gz) |
| **cyphernetes** | 0.18.2 | 14 MiB | `677e0d3611c2` | [bottle](https://homebrewloongarch64.site/brew/bottles/cyphernetes--0.18.2.loongarch64.bottle.tar.gz) |
| **dagger** | 0.21.11 | 8.0 MiB | `ce6d67939040` | [bottle](https://homebrewloongarch64.site/brew/bottles/dagger--0.21.11.loongarch64.bottle.tar.gz) |
| **dagu** | 2.23.0 | 46 MiB | `3c722dbda418` | [bottle](https://homebrewloongarch64.site/brew/bottles/dagu--2.23.0.loongarch64.bottle.tar.gz) |
| **dapr** | 1.19.0 | 18 MiB | `8ddbfdd562d7` | [bottle](https://homebrewloongarch64.site/brew/bottles/dapr--1.19.0.loongarch64.bottle.tar.gz) |
| **darkflare** | 1.3.3 | 2.3 MiB | `e3b45ce87d4f` | [bottle](https://homebrewloongarch64.site/brew/bottles/darkflare--1.3.3.loongarch64.bottle.tar.gz) |
| **dasel** | 3.11.2 | 3.7 MiB | `08db4dc60d52` | [bottle](https://homebrewloongarch64.site/brew/bottles/dasel--3.11.2.loongarch64.bottle.tar.gz) |
| **dashing** | 0.4.0 | 2.0 MiB | `70bf77ffb998` | [bottle](https://homebrewloongarch64.site/brew/bottles/dashing--0.4.0.loongarch64.bottle.tar.gz) |
| **daylight** | 1.3.0 | 2.4 MiB | `6c3ddcabc55c` | [bottle](https://homebrewloongarch64.site/brew/bottles/daylight--1.3.0.loongarch64.bottle.tar.gz) |
| **dblab** | 0.54.0 | 12 MiB | `731b8901cc10` | [bottle](https://homebrewloongarch64.site/brew/bottles/dblab--0.54.0.loongarch64.bottle.tar.gz) |
| **dbmate** | 2.37.0 | 10.0 MiB | `958b08c270b7` | [bottle](https://homebrewloongarch64.site/brew/bottles/dbmate--2.37.0.loongarch64.bottle.tar.gz) |
| **dbxcli** | 3.7.4 | 3.4 MiB | `7e3a06ac5f19` | [bottle](https://homebrewloongarch64.site/brew/bottles/dbxcli--3.7.4.loongarch64.bottle.tar.gz) |
| **ddev** | 1.25.5 | 13 MiB | `1678e0bc1ded` | [bottle](https://homebrewloongarch64.site/brew/bottles/ddev--1.25.5.loongarch64.bottle.tar.gz) |
| **ddns-go** | 6.17.7 | 4.5 MiB | `b175400e0255` | [bottle](https://homebrewloongarch64.site/brew/bottles/ddns-go--6.17.7.loongarch64.bottle.tar.gz) |
| **ddns-updater** | 2.10.0 | 5.2 MiB | `8b0c6d6727dd` | [bottle](https://homebrewloongarch64.site/brew/bottles/ddns-updater--2.10.0.loongarch64.bottle.tar.gz) |
| **deck** | 1.24.4 | 4.7 MiB | `67778e2c99ac` | [bottle](https://homebrewloongarch64.site/brew/bottles/deck--1.24.4.loongarch64.bottle.tar.gz) |
| **decompose** | 1.11.8 | 4.2 MiB | `c96a55a931fd` | [bottle](https://homebrewloongarch64.site/brew/bottles/decompose--1.11.8.loongarch64.bottle.tar.gz) |
| **deepseek-reasonix** | studio-v2.53.1 | 4.6 MiB | `3467c3b5a8b7` | [bottle](https://homebrewloongarch64.site/brew/bottles/deepseek-reasonix--studio-v2.53.1.loongarch64.bottle.tar.gz) |
| **deja** | 0.4.2 | 1.6 MiB | `de1b344faeca` | [bottle](https://homebrewloongarch64.site/brew/bottles/deja--0.4.2.loongarch64.bottle.tar.gz) |
| **delta** | 0.20.1 | 3.1 MiB | `6fb566f53a0b` | [bottle](https://homebrewloongarch64.site/brew/bottles/delta--0.20.1.loongarch64.bottle.tar.gz) |
| **demo** | 0.1.1 | 1.1 MiB | `a24d82cb477d` | [bottle](https://homebrewloongarch64.site/brew/bottles/demo--0.1.1.loongarch64.bottle.tar.gz) |
| **dep-tree** | 0.23.4 | 3.8 MiB | `f326fb8d1039` | [bottle](https://homebrewloongarch64.site/brew/bottles/dep-tree--0.23.4.loongarch64.bottle.tar.gz) |
| **dependabot** | 1.96.0 | 7.9 MiB | `07276d391e42` | [bottle](https://homebrewloongarch64.site/brew/bottles/dependabot--1.96.0.loongarch64.bottle.tar.gz) |
| **depot** | 2.103.3 | 13 MiB | `4a65d90651ee` | [bottle](https://homebrewloongarch64.site/brew/bottles/depot--2.103.3.loongarch64.bottle.tar.gz) |
| **descheduler** | descheduler-helm-chart-0.37.0 | 20 MiB | `8f1e49d8e69c` | [bottle](https://homebrewloongarch64.site/brew/bottles/descheduler--descheduler-helm-chart-0.37.0.loongarch64.bottle.tar.gz) |
| **descope** | 0.8.16 | 2.9 MiB | `42b74307ba4b` | [bottle](https://homebrewloongarch64.site/brew/bottles/descope--0.8.16.loongarch64.bottle.tar.gz) |
| **devcockpit** | 3.0.0 | 6.3 MiB | `a2f1c904cad4` | [bottle](https://homebrewloongarch64.site/brew/bottles/devcockpit--3.0.0.loongarch64.bottle.tar.gz) |
| **devpod** | 0.6.15 | 22 MiB | `eaff2f225c70` | [bottle](https://homebrewloongarch64.site/brew/bottles/devpod--0.6.15.loongarch64.bottle.tar.gz) |
| **devspace** | 6.3.21 | 27 MiB | `87c289ebcb2e` | [bottle](https://homebrewloongarch64.site/brew/bottles/devspace--6.3.21.loongarch64.bottle.tar.gz) |
| **dex** | 2.46.1 | 13 MiB | `920626cb268c` | [bottle](https://homebrewloongarch64.site/brew/bottles/dex--2.46.1.loongarch64.bottle.tar.gz) |
| **dexidp** | 2.46.1 | 13 MiB | `7aa30ad10bf9` | [bottle](https://homebrewloongarch64.site/brew/bottles/dexidp--2.46.1.loongarch64.bottle.tar.gz) |
| **didder** | 1.3.0 | 2.4 MiB | `3f13756e6bc2` | [bottle](https://homebrewloongarch64.site/brew/bottles/didder--1.3.0.loongarch64.bottle.tar.gz) |
| **diff-tour** | 0.6.0 | 14 MiB | `824be760d8c7` | [bottle](https://homebrewloongarch64.site/brew/bottles/diff-tour--0.6.0.loongarch64.bottle.tar.gz) |
| **diffnav** | 0.13.0 | 4.9 MiB | `5d73a0502dab` | [bottle](https://homebrewloongarch64.site/brew/bottles/diffnav--0.13.0.loongarch64.bottle.tar.gz) |
| **diffoci** | 0.1.8 | 6.8 MiB | `8056c4745ccb` | [bottle](https://homebrewloongarch64.site/brew/bottles/diffoci--0.1.8.loongarch64.bottle.tar.gz) |
| **difftastic** | 0.71.0 | 11 MiB | `98edcc089cac` | [bottle](https://homebrewloongarch64.site/brew/bottles/difftastic--0.71.0.loongarch64.bottle.tar.gz) |
| **difi** | 0.2.31 | 2.9 MiB | `da15da2feb48` | [bottle](https://homebrewloongarch64.site/brew/bottles/difi--0.2.31.loongarch64.bottle.tar.gz) |
| **diny** | 0.7.8 | 3.6 MiB | `d64fe88d92d8` | [bottle](https://homebrewloongarch64.site/brew/bottles/diny--0.7.8.loongarch64.bottle.tar.gz) |
| **direnv** | 2.38.2 | 3.4 MiB | `21e86279a5a0` | [bottle](https://homebrewloongarch64.site/brew/bottles/direnv--2.38.2.loongarch64.bottle.tar.gz) |
| **dish** | 1.12.0 | 845 KiB | `2125241fc471` | [bottle](https://homebrewloongarch64.site/brew/bottles/dish--1.12.0.loongarch64.bottle.tar.gz) |
| **diskusage** | 1.2.8 | 2.0 MiB | `9e5c5f3531d5` | [bottle](https://homebrewloongarch64.site/brew/bottles/diskusage--1.2.8.loongarch64.bottle.tar.gz) |
| **dive** | 0.13.1 | 4.0 MiB | `60c662144eb9` | [bottle](https://homebrewloongarch64.site/brew/bottles/dive--0.13.1.loongarch64.bottle.tar.gz) |
| **dnote** | cli-v0.17.0 | 3.2 MiB | `dd5edc23add5` | [bottle](https://homebrewloongarch64.site/brew/bottles/dnote--cli-v0.17.0.loongarch64.bottle.tar.gz) |
| **dnscontrol** | 5.7.1 | 29 MiB | `0a8a534f2bf4` | [bottle](https://homebrewloongarch64.site/brew/bottles/dnscontrol--5.7.1.loongarch64.bottle.tar.gz) |
| **dnscrypt-proxy** | 2.1.20 | 4.6 MiB | `e38081ae3dfb` | [bottle](https://homebrewloongarch64.site/brew/bottles/dnscrypt-proxy--2.1.20.loongarch64.bottle.tar.gz) |
| **dnspyre** | 3.12.0 | 10 MiB | `93e13c580245` | [bottle](https://homebrewloongarch64.site/brew/bottles/dnspyre--3.12.0.loongarch64.bottle.tar.gz) |
| **dnsx** | 1.3.1 | 9.0 MiB | `6545146b1ab0` | [bottle](https://homebrewloongarch64.site/brew/bottles/dnsx--1.3.1.loongarch64.bottle.tar.gz) |
| **docker-agent** | 1.152.0 | 35 MiB | `b131811b3d83` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-agent--1.152.0.loongarch64.bottle.tar.gz) |
| **docker-buildx** | 0.38.1 | 21 MiB | `b1ddbddd92d2` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-buildx--0.38.1.loongarch64.bottle.tar.gz) |
| **docker-compose** | 5.6.1 | 9.7 MiB | `9da5e382a442` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-compose--5.6.1.loongarch64.bottle.tar.gz) |
| **docker-credential-helper** | 0.9.12 | 1.2 MiB | `001be52e933e` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-credential-helper--0.9.12.loongarch64.bottle.tar.gz) |
| **docker-debug** | 0.7.11 | 4.2 MiB | `546b375684e5` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-debug--0.7.11.loongarch64.bottle.tar.gz) |
| **docker-engine** | docker-v29.9.2 | 1.0 MiB | `c7d131dcd2de` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-engine--docker-v29.9.2.loongarch64.bottle.tar.gz) |
| **docker-language-server** | 0.20.1 | 71 MiB | `021ba454b5bc` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-language-server--0.20.1.loongarch64.bottle.tar.gz) |
| **docker-ls** | 0.5.1 | 4.5 MiB | `d57933c4289f` | [bottle](https://homebrewloongarch64.site/brew/bottles/docker-ls--0.5.1.loongarch64.bottle.tar.gz) |

> 仅显示前 60 个，共 **1045** 个。完整列表见 [搜索页](https://homebrewloongarch64.site/brew/search.html)。

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
