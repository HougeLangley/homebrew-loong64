# homebrew-loong64

[![arch](https://img.shields.io/badge/arch-loongarch64-blue)](https://loongson.cn)
[![packages](https://img.shields.io/badge/packages-2320-brightgreen)](#-可用软件包)
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
# 注意：brew tap 要求当天已经执行过 brew update，
# 否则会报 "You have disabled automatic updates and have not updated today."
brew update
brew tap loongarch64/loong64 https://homebrewloongarch64.site/git/brew-tap.git
brew trust loongarch64/loong64    # brew 7 要求显式信任第三方 tap
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

> 本表由发布流水线自动生成（2026-11-06 15:35 (UTC+8)），与站点索引 `index.json` 实时同源。

| 包 | 版本 | 大小 | SHA-256（前 12 位） | 下载 |
|---|---|---|---|---|
| **a52dec** | 0.8.0 | 105 KiB | `328fcae652f2` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/a52dec--0.8.0.loongarch64_linux.bottle.1.tar.gz) |
| **aamath** | 0.3 | 55 KiB | `9557d9bfdf2d` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aamath--0.3.loongarch64_linux.bottle.tar.gz) |
| **abcm2ps** | 8.14.18 | 273 KiB | `b3d7b1a272af` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abcm2ps--8.14.18.loongarch64_linux.bottle.1.tar.gz) |
| **abcmidi** | 2026.10.23 | 657 KiB | `c6da3317eb76` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abcmidi--2026.10.23.loongarch64_linux.bottle.1.tar.gz) |
| **abduco** | 0.6 | 19 KiB | `54c10a485822` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abduco--0.6.loongarch64_linux.bottle.1.tar.gz) |
| **abnfgen** | 0.21 | 30 KiB | `4f670ad0e7cd` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abnfgen--0.21.loongarch64_linux.bottle.1.tar.gz) |
| **abook** | 0.6.2 | 114 KiB | `bd10eeaa231a` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abook--0.6.2.loongarch64_linux.bottle.tar.gz) |
| **abpoa** | 1.5.7 | 123 KiB | `8ccf6ab9cfc7` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abpoa--1.5.7.loongarch64_linux.bottle.1.tar.gz) |
| **abseil** | 20260817.0 | 2.3 MiB | `b1a623e1adbd` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/abseil--20260817.0.loongarch64_linux.bottle.2.tar.gz) |
| **ace** | 8.0.8 | 5.0 MiB | `ad927a435e0e` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ace--8.0.8.loongarch64_linux.bottle.1.tar.gz) |
| **aces_container** | 1.0.2 | 58 KiB | `0b23e5b0a39b` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aces_container--1.0.2.loongarch64_linux.bottle.1.tar.gz) |
| **acl** | 2.4.0 | 187 KiB | `2ae7f6a8f50f` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/acl--2.4.0.loongarch64_linux.bottle.1.tar.gz) |
| **acme** | 0.97 | 114 KiB | `4bdb29791299` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/acme--0.97.loongarch64_linux.bottle.2.tar.gz) |
| **acme.sh** | 3.1.6 | 460 KiB | `606317189ef8` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/acme.sh--3.1.6.loongarch64_linux.bottle.1.tar.gz) |
| **acpica** | 20260408 | 1.3 MiB | `8f85a6d8863c` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/acpica--20260408.loongarch64_linux.bottle.1.tar.gz) |
| **activemq-cpp** | 3.9.5_2 | 26 MiB | `d7ce5896d2ad` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/activemq-cpp--3.9.5_2.loongarch64_linux.bottle.tar.gz) |
| **adamstark-audiofile** | 1.1.4 | 16 KiB | `303a29daf658` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/adamstark-audiofile--1.1.4.loongarch64_linux.bottle.1.tar.gz) |
| **adns** | 1.7.0 | 419 KiB | `240061e69baa` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/adns--1.7.0.loongarch64_linux.bottle.1.tar.gz) |
| **adplug** | 2.4 | 1.2 MiB | `49641483f57a` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/adplug--2.4.loongarch64_linux.bottle.tar.gz) |
| **adr-tools** | 3.0.0 | 8.8 KiB | `c8cab39f83ff` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/adr-tools--3.0.0.loongarch64_linux.bottle.3.tar.gz) |
| **advancecomp** | 2.6 | 657 KiB | `7f441b35ddf3` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/advancecomp--2.6.loongarch64_linux.bottle.2.tar.gz) |
| **aescrypt** | 0.7 | 57 KiB | `224238e86119` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aescrypt--0.7.loongarch64_linux.bottle.tar.gz) |
| **aescrypt-packetizer** | 3.16 | 57 KiB | `224238e86119` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aescrypt-packetizer--3.16.loongarch64_linux.bottle.1.tar.gz) |
| **aespipe** | 2.4j | 48 KiB | `5a7553b91182` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aespipe--2.4j.loongarch64_linux.bottle.1.tar.gz) |
| **afio** | 2.5.2 | 87 KiB | `112af90caed6` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/afio--2.5.2.loongarch64_linux.bottle.2.tar.gz) |
| **aften** | 0.0.8 | 220 KiB | `8982a958e591` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aften--0.0.8.loongarch64_linux.bottle.1.tar.gz) |
| **agedu** | 20260410 | 63 KiB | `ae64e247d402` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/agedu--20260410.loongarch64_linux.bottle.1.tar.gz) |
| **aha** | 0.5.1 | 35 KiB | `e0f75992b8cc` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aha--0.5.1.loongarch64_linux.bottle.1.tar.gz) |
| **ahcpd** | 0.53 | 36 KiB | `c5b7d73f9830` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ahcpd--0.53.loongarch64_linux.bottle.2.tar.gz) |
| **aklomp-base64** | 0.5.2 | 32 KiB | `f4a3eea32d00` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aklomp-base64--0.5.2.loongarch64_linux.bottle.1.tar.gz) |
| **aldo** | 0.7.7 | 88 KiB | `dcf38f91bcc5` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aldo--0.7.7.loongarch64_linux.bottle.2.tar.gz) |
| **align** | 1.7.5 | 13 KiB | `32199dde3bcf` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/align--1.7.5.loongarch64_linux.bottle.4.tar.gz) |
| **alpine** | 2.26 | 5.3 MiB | `2be1048de69f` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/alpine--2.26.loongarch64_linux.bottle.tar.gz) |
| **alsa-lib** | 1.2.16.1_1 | 744 KiB | `b7fe8d46cb6e` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/alsa-lib--1.2.16.1_1.loongarch64_linux.bottle.1.tar.gz) |
| **ampl-asl** | 1.0.1 | 646 KiB | `b4a0006992b8` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ampl-asl--1.0.1.loongarch64_linux.bottle.1.tar.gz) |
| **ampl-mp** | 4.1.0 | 741 KiB | `1db3ea5a7431` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ampl-mp--4.1.0.loongarch64_linux.bottle.1.tar.gz) |
| **amqp-cpp** | 4.3.27_1 | 299 KiB | `602ae14d3052` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/amqp-cpp--4.3.27_1.loongarch64_linux.bottle.1.tar.gz) |
| **analog** | 6.0.18 | 1.2 MiB | `67b351c8fa04` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/analog--6.0.18.loongarch64_linux.bottle.2.tar.gz) |
| **ancient** | 2.3.0 | 1010 KiB | `cde17c6855d9` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ancient--2.3.0.loongarch64_linux.bottle.1.tar.gz) |
| **android-file-transfer-linux** | 4.6 | 310 KiB | `b7cde767d7e3` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/android-file-transfer-linux--4.6.loongarch64_linux.bottle.1.tar.gz) |
| **angband** | 4.2.6 | 23 MiB | `53fe4e153394` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/angband--4.2.6.loongarch64_linux.bottle.1.tar.gz) |
| **ansifilter** | 2.24 | 152 KiB | `546e9fcd17b7` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ansifilter--2.24.loongarch64_linux.bottle.1.tar.gz) |
| **ansilove** | 4.2.2 | 24 KiB | `7d23de84a78e` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ansilove--4.2.2.loongarch64_linux.bottle.1.tar.gz) |
| **ansiweather** | 1.19.1 | 10 KiB | `5975d6cd86b3` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/ansiweather--1.19.1.loongarch64_linux.bottle.1.tar.gz) |
| **antidote** | 2.3.0 | 50 KiB | `322e458cde22` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/antidote--2.3.0.loongarch64_linux.bottle.1.tar.gz) |
| **antigen** | 2.2.3 | 26 KiB | `6f57d89d3dff` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/antigen--2.2.3.loongarch64_linux.bottle.3.tar.gz) |
| **antlr4-cpp-runtime** | 4.13.2_1 | 2.0 MiB | `14e1001bd35d` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/antlr4-cpp-runtime--4.13.2_1.loongarch64_linux.bottle.1.tar.gz) |
| **any2fasta** | 0.8.1 | 19 KiB | `124822ef45ff` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/any2fasta--0.8.1.loongarch64_linux.bottle.1.tar.gz) |
| **anyenv** | 1.1.5 | 11 KiB | `aa9267f441d9` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/anyenv--1.1.5.loongarch64_linux.bottle.2.tar.gz) |
| **aoeui** | 1.6 | 112 KiB | `c17e1bb24d6b` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/aoeui--1.6.loongarch64_linux.bottle.1.tar.gz) |
| **apache-arrow-adbc** | 25 | 212 KiB | `f0bc26e28e36` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apache-arrow-adbc--25.loongarch64_linux.bottle.1.tar.gz) |
| **apcupsd** | 3.14.14 | 543 KiB | `6bf8fa075f96` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apcupsd--3.14.14.loongarch64_linux.bottle.tar.gz) |
| **apib** | 1.2.1 | 219 KiB | `a718845aa422` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apib--1.2.1.loongarch64_linux.bottle.3.tar.gz) |
| **apibuilder-cli** | 0.2.4 | 56 KiB | `653add821883` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apibuilder-cli--0.2.4.loongarch64_linux.bottle.1.tar.gz) |
| **apm-bash-completion** | 1.0.0 | 2.7 KiB | `3260f3cb5ba3` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apm-bash-completion--1.0.0.loongarch64_linux.bottle.3.tar.gz) |
| **apng2gif** | 1.8 | 19 KiB | `351a9ac006a1` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apng2gif--1.8.loongarch64_linux.bottle.2.tar.gz) |
| **apparix** | 11-062 | 128 KiB | `ac09d409fb44` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apparix--11-062.loongarch64_linux.bottle.2.tar.gz) |
| **apr** | 1.7.6 | 612 KiB | `650e8690586a` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apr--1.7.6.loongarch64_linux.bottle.tar.gz) |
| **apr-util** | 1.6.5_1 | 612 KiB | `650e8690586a` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/apr-util--1.6.5_1.loongarch64_linux.bottle.1.tar.gz) |
| **archivemount** | 1c | 31 KiB | `772263040fcd` | [bottle](https://homebrewloongarch64.site/brew/../brew-bottles/archivemount--1c.loongarch64_linux.bottle.1.tar.gz) |

> 仅显示前 60 个，共 **2320** 个。完整列表见 [搜索页](https://homebrewloongarch64.site/brew/search.html)。

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
