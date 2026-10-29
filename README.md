# homebrew-loong64

[![arch](https://img.shields.io/badge/arch-loongarch64-blue)](https://loongson.cn)
[![packages](https://img.shields.io/badge/packages-1661-brightgreen)](#-可用软件包)
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


## 🍺 在龙芯上安装 Homebrew（本项目核心）

Homebrew 官方不支持 loongarch64。本项目提供了**可用的移植补丁与安装脚本**，让 brew 本体能在龙芯上运行：

```bash
curl -fsSL https://homebrewloongarch64.site/install-brew.sh | bash

# 或自定义前缀
curl -fsSL https://homebrewloongarch64.site/install-brew.sh | bash -s -- --prefix ~/.linuxbrew
```

安装完成后按提示执行 `eval "$(<prefix>/bin/brew shellenv)"`，然后即可：

```bash
brew install --build-from-source tree
```

**做了什么适配**（补丁见 [`brew-loongarch64.patch`](https://homebrewloongarch64.site/brew-loongarch64.patch)）：

| 问题 | 处理 |
|---|---|
| brew ≥6.0 要求 Ruby 4.0，AOSC 官方源只有 3.4 | 本项目自建 **Ruby 4.0.9** 包，发布在第三方 APT 源；brew 用最新 **7.0.11** |
| 架构检查写死 x86/ARM | 补丁允许 `loongarch64` |
| 动态链接器列表缺龙芯 | 补丁加入 `/lib64/ld-linux-loongarch-lp64d.so.1` |


### 用 bottle 秒装（推荐）

龙芯也有预编译 bottle 了。装好 brew 后：

```bash
brew tap loongarch64/loong64 https://homebrewloongarch64.site/git/brew-tap.git
brew install loongarch64/loong64/tree      # 直接从 bottle 灌注，几秒完成
```

Bottle 由本项目用 brew 自身构建：`brew install --build-bottle` → `brew test` → `brew bottle`，
产物发布到 <https://homebrewloongarch64.site/brew-bottles/>。


### 先安装 Ruby 4.0（一次性）

```bash
curl -fsSL https://homebrewloongarch64.site/aosc/thirdparty.asc | sudo tee /etc/apt/trusted.gpg.d/homebrew-loong64.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/homebrew-loong64.gpg] https://homebrewloongarch64.site/aosc stable main" \
  | sudo tee /etc/apt/sources.list.d/homebrew-loong64.list
sudo apt update && sudo apt install ruby   # 升级到 4.0.9
```

**限制**：龙芯没有官方 bottle，所有 formula 都从源码构建；首次安装需要拉取 JSON API（约 20MB）。

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

> 本表由发布流水线自动生成（2026-10-29 09:58 (UTC+8)），与站点索引 `index.json` 实时同源。

| 包 | 版本 | 大小 | SHA-256（前 12 位） | 下载 |
|---|---|---|---|---|
| **a2ps** | 4.15.8 | 176 KiB | `6219fc9df570` | [bottle](https://homebrewloongarch64.site/brew/bottles/a2ps--4.15.8.loongarch64.bottle.tar.gz) |
| **a52dec** | 0.8.0 | 40 KiB | `9e4c2e03ad27` | [bottle](https://homebrewloongarch64.site/brew/bottles/a52dec--0.8.0.loongarch64.bottle.tar.gz) |
| **abnfgen** | 0.21 | 21 KiB | `b00dbf1f887f` | [bottle](https://homebrewloongarch64.site/brew/bottles/abnfgen--0.21.loongarch64.bottle.tar.gz) |
| **abtop** | 0.5.5 | 905 KiB | `ef7bcbaf53c4` | [bottle](https://homebrewloongarch64.site/brew/bottles/abtop--0.5.5.loongarch64.bottle.tar.gz) |
| **acl** | 2.4.0 | 18 KiB | `d9d41108028e` | [bottle](https://homebrewloongarch64.site/brew/bottles/acl--2.4.0.loongarch64.bottle.tar.gz) |
| **acmd** | 0.12.0 | 548 KiB | `cfee8281e21e` | [bottle](https://homebrewloongarch64.site/brew/bottles/acmd--0.12.0.loongarch64.bottle.tar.gz) |
| **aconfig** | 0.19.0 | 193 KiB | `dca5b5b860ba` | [bottle](https://homebrewloongarch64.site/brew/bottles/aconfig--0.19.0.loongarch64.bottle.tar.gz) |
| **act** | 0.2.89 | 7.6 MiB | `83ab35debd65` | [bottle](https://homebrewloongarch64.site/brew/bottles/act--0.2.89.loongarch64.bottle.tar.gz) |
| **actionlint** | 1.7.12 | 2.2 MiB | `7616c8912b41` | [bottle](https://homebrewloongarch64.site/brew/bottles/actionlint--1.7.12.loongarch64.bottle.tar.gz) |
| **actions-batch** | 0.0.3 | 1.6 MiB | `19578ca8971c` | [bottle](https://homebrewloongarch64.site/brew/bottles/actions-batch--0.0.3.loongarch64.bottle.tar.gz) |
| **actions-runner-controller** | gha-runner-scale-set-0.15.1 | 11 MiB | `2d9895557c12` | [bottle](https://homebrewloongarch64.site/brew/bottles/actions-runner-controller--gha-runner-scale-set-0.15.1.loongarch64.bottle.tar.gz) |
| **addlicense** | 1.2.0 | 1.2 MiB | `9fc8e9edd0aa` | [bottle](https://homebrewloongarch64.site/brew/bottles/addlicense--1.2.0.loongarch64.bottle.tar.gz) |
| **addon-controller** | 1.16.1 | 731 KiB | `ee404340ac27` | [bottle](https://homebrewloongarch64.site/brew/bottles/addon-controller--1.16.1.loongarch64.bottle.tar.gz) |
| **addon-operator** | 1.26.2 | 27 MiB | `3f8f517f4572` | [bottle](https://homebrewloongarch64.site/brew/bottles/addon-operator--1.26.2.loongarch64.bottle.tar.gz) |
| **advancecomp** | 2.6 | 137 KiB | `4163dd783a82` | [bottle](https://homebrewloongarch64.site/brew/bottles/advancecomp--2.6.loongarch64.bottle.tar.gz) |
| **aeman** | 0.33.1 | 5.6 MiB | `3eef0d8ad4bd` | [bottle](https://homebrewloongarch64.site/brew/bottles/aeman--0.33.1.loongarch64.bottle.tar.gz) |
| **aerospace-marks** | 1.0.3 | 1.8 MiB | `7ca7029466b4` | [bottle](https://homebrewloongarch64.site/brew/bottles/aerospace-marks--1.0.3.loongarch64.bottle.tar.gz) |
| **aerospace-scratchpad** | 0.7.1 | 2.7 MiB | `d2878572cf3f` | [bottle](https://homebrewloongarch64.site/brew/bottles/aerospace-scratchpad--0.7.1.loongarch64.bottle.tar.gz) |
| **afl++** | 5.03c | 875 B | `0025928cafc1` | [bottle](https://homebrewloongarch64.site/brew/bottles/afl++--5.03c.loongarch64.bottle.tar.gz) |
| **age** | 1.3.2 | 2.0 MiB | `75ee1bd16b3c` | [bottle](https://homebrewloongarch64.site/brew/bottles/age--1.3.2.loongarch64.bottle.tar.gz) |
| **agedu** | 20260410 | 47 KiB | `d18bf9fb1c58` | [bottle](https://homebrewloongarch64.site/brew/bottles/agedu--20260410.loongarch64.bottle.tar.gz) |
| **agent-deck** | 1.16.34 | 17 MiB | `d5f06bd47234` | [bottle](https://homebrewloongarch64.site/brew/bottles/agent-deck--1.16.34.loongarch64.bottle.tar.gz) |
| **agent-lsp** | 0.23.4 | 3.8 MiB | `2ef6ab0951f3` | [bottle](https://homebrewloongarch64.site/brew/bottles/agent-lsp--0.23.4.loongarch64.bottle.tar.gz) |
| **agent-manager** | 0.44.0 | 8.5 MiB | `d9be46163e97` | [bottle](https://homebrewloongarch64.site/brew/bottles/agent-manager--0.44.0.loongarch64.bottle.tar.gz) |
| **agent-notifications** | 1.49.9 | 2.1 MiB | `205dc3fa46cc` | [bottle](https://homebrewloongarch64.site/brew/bottles/agent-notifications--1.49.9.loongarch64.bottle.tar.gz) |
| **agent-sandbox** | 1.0.8 | 12 MiB | `0b75fb1e2a8c` | [bottle](https://homebrewloongarch64.site/brew/bottles/agent-sandbox--1.0.8.loongarch64.bottle.tar.gz) |
| **agentdock** | 1.1.1 | 7.1 MiB | `402eaa20c2e6` | [bottle](https://homebrewloongarch64.site/brew/bottles/agentdock--1.1.1.loongarch64.bottle.tar.gz) |
| **agenticgokit** | 0.5.9 | 5.6 MiB | `c11b2784f34c` | [bottle](https://homebrewloongarch64.site/brew/bottles/agenticgokit--0.5.9.loongarch64.bottle.tar.gz) |
| **aha** | 0.5.1 | 11 KiB | `972369f574ed` | [bottle](https://homebrewloongarch64.site/brew/bottles/aha--0.5.1.loongarch64.bottle.tar.gz) |
| **ahoy** | 3.0.2 | 3.2 MiB | `d5b2110cd21c` | [bottle](https://homebrewloongarch64.site/brew/bottles/ahoy--3.0.2.loongarch64.bottle.tar.gz) |
| **ai-resource-manager** | 5.0.0 | 3.8 MiB | `0840455c2629` | [bottle](https://homebrewloongarch64.site/brew/bottles/ai-resource-manager--5.0.0.loongarch64.bottle.tar.gz) |
| **aiac** | 5.3.0 | 4.8 MiB | `918443c5e7ef` | [bottle](https://homebrewloongarch64.site/brew/bottles/aiac--5.3.0.loongarch64.bottle.tar.gz) |
| **aicommit** | 0.6.5 | 6.2 MiB | `ecda7b5580db` | [bottle](https://homebrewloongarch64.site/brew/bottles/aicommit--0.6.5.loongarch64.bottle.tar.gz) |
| **aide** | 0.19.5 | 96 KiB | `60289ccba32e` | [bottle](https://homebrewloongarch64.site/brew/bottles/aide--0.19.5.loongarch64.bottle.tar.gz) |
| **ain** | 1.6.0 | 7.1 MiB | `ef91f42bd149` | [bottle](https://homebrewloongarch64.site/brew/bottles/ain--1.6.0.loongarch64.bottle.tar.gz) |
| **air** | 1.67.4 | 4.3 MiB | `2ab648974f5c` | [bottle](https://homebrewloongarch64.site/brew/bottles/air--1.67.4.loongarch64.bottle.tar.gz) |
| **airo** | 0.0.1 | 42 KiB | `8ee669ee0708` | [bottle](https://homebrewloongarch64.site/brew/bottles/airo--0.0.1.loongarch64.bottle.tar.gz) |
| **akamai** | 2.0.5 | 48 MiB | `badec1865237` | [bottle](https://homebrewloongarch64.site/brew/bottles/akamai--2.0.5.loongarch64.bottle.tar.gz) |
| **akku** | 1.2.0 | 4.5 KiB | `c9c8aee5c797` | [bottle](https://homebrewloongarch64.site/brew/bottles/akku--1.2.0.loongarch64.bottle.tar.gz) |
| **aklomp-base64** | 0.5.2 | 15 KiB | `9ac84ebdb182` | [bottle](https://homebrewloongarch64.site/brew/bottles/aklomp-base64--0.5.2.loongarch64.bottle.tar.gz) |
| **alfred-aws-console-services-workflow** | 6.2.0 | 4.7 MiB | `3bfc1d4ca9b2` | [bottle](https://homebrewloongarch64.site/brew/bottles/alfred-aws-console-services-workflow--6.2.0.loongarch64.bottle.tar.gz) |
| **alfredo** | 0.6.1 | 709 KiB | `d9e5ebe534d9` | [bottle](https://homebrewloongarch64.site/brew/bottles/alfredo--0.6.1.loongarch64.bottle.tar.gz) |
| **algernon** | 1.17.12 | 16 MiB | `1a83e7ea8036` | [bottle](https://homebrewloongarch64.site/brew/bottles/algernon--1.17.12.loongarch64.bottle.tar.gz) |
| **algol68g** | 3.13.4 | 672 KiB | `a32825d4e2a4` | [bottle](https://homebrewloongarch64.site/brew/bottles/algol68g--3.13.4.loongarch64.bottle.tar.gz) |
| **algolia** | 1.18.0 | 2.6 MiB | `cda4bf38a479` | [bottle](https://homebrewloongarch64.site/brew/bottles/algolia--1.18.0.loongarch64.bottle.tar.gz) |
| **ali** | 0.8.0 | 3.9 MiB | `56f11085fd17` | [bottle](https://homebrewloongarch64.site/brew/bottles/ali--0.8.0.loongarch64.bottle.tar.gz) |
| **aliae** | 1.6.0 | 7.1 MiB | `e81bc86db71b` | [bottle](https://homebrewloongarch64.site/brew/bottles/aliae--1.6.0.loongarch64.bottle.tar.gz) |
| **aliddns** | 0.0.23 | 4.4 MiB | `0147f60890b5` | [bottle](https://homebrewloongarch64.site/brew/bottles/aliddns--0.0.23.loongarch64.bottle.tar.gz) |
| **aliyun-cli** | 3.5.2 | 942 KiB | `e2a970a42040` | [bottle](https://homebrewloongarch64.site/brew/bottles/aliyun-cli--3.5.2.loongarch64.bottle.tar.gz) |
| **alp** | 1.0.22 | 4.2 MiB | `d7ec584605f7` | [bottle](https://homebrewloongarch64.site/brew/bottles/alp--1.0.22.loongarch64.bottle.tar.gz) |
| **amass** | 5.1.3 | 4.2 MiB | `3262e9b947ee` | [bottle](https://homebrewloongarch64.site/brew/bottles/amass--5.1.3.loongarch64.bottle.tar.gz) |
| **amfora** | 1.11.0 | 3.7 MiB | `27b81bf852f2` | [bottle](https://homebrewloongarch64.site/brew/bottles/amfora--1.11.0.loongarch64.bottle.tar.gz) |
| **antrea** | 2.7.0 | 10 MiB | `6dc6cf2dc6fc` | [bottle](https://homebrewloongarch64.site/brew/bottles/antrea--2.7.0.loongarch64.bottle.tar.gz) |
| **anubis** | 1.28.2 | 4.6 KiB | `d2549ded6f66` | [bottle](https://homebrewloongarch64.site/brew/bottles/anubis--1.28.2.loongarch64.bottle.tar.gz) |
| **anvil** | 2.9.0 | 3.1 MiB | `f29ab1c9e2fd` | [bottle](https://homebrewloongarch64.site/brew/bottles/anvil--2.9.0.loongarch64.bottle.tar.gz) |
| **anycable-go** | 1.6.20 | 12 MiB | `41de4a02ddf1` | [bottle](https://homebrewloongarch64.site/brew/bottles/anycable-go--1.6.20.loongarch64.bottle.tar.gz) |
| **api-linter** | 2.4.0 | 1.4 MiB | `70d53d982714` | [bottle](https://homebrewloongarch64.site/brew/bottles/api-linter--2.4.0.loongarch64.bottle.tar.gz) |
| **api-testing** | 0.0.21 | 9.3 MiB | `3288c0e257d5` | [bottle](https://homebrewloongarch64.site/brew/bottles/api-testing--0.0.21.loongarch64.bottle.tar.gz) |
| **apigeecli** | 2.17.0 | 6.6 MiB | `563bf2a8fc17` | [bottle](https://homebrewloongarch64.site/brew/bottles/apigeecli--2.17.0.loongarch64.bottle.tar.gz) |
| **apisix-ingress-controller** | 2.2.0 | 16 MiB | `118260e51845` | [bottle](https://homebrewloongarch64.site/brew/bottles/apisix-ingress-controller--2.2.0.loongarch64.bottle.tar.gz) |

> 仅显示前 60 个，共 **1661** 个。完整列表见 [搜索页](https://homebrewloongarch64.site/brew/search.html)。

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
