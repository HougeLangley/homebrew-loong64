# Homebrew LoongArch 构建进展报告

> **报告时间**: 2026-03-31  
> **架构**: loongarch64  
> **容器**: systemd-nspawn (homebrew-build)  
> **OS**: AOSC OS 13.1.4 (Meow)  
> **总包数**: 64 个 (Phase 1 完成)

---

## 🔑 关键环境信息（必读）

### SSH 连接编译机

```bash
# 连接到 LoongArch 编译机
ssh houge@192.168.50.244

# 系统信息
# - OS: AOSC OS (Linux 中国社区发行版)
# - 架构: LoongArch (loongarch64)
# - 认证: 公钥认证（无需密码）
```

### 进入构建容器

**重要：所有构建必须在容器中进行，确保环境隔离**

```bash
# 进入 systemd-nspawn 容器
sudo systemd-nspawn -D /var/lib/machines/homebrew-build --user=brewbuilder

# 容器内环境
# - 用户: brewbuilder
# - Homebrew: /home/brew-build/brew
# - 构建目录: /home/brewbuilder/build
```

### 必需环境变量

```bash
export PATH=/home/brew-build/brew/bin:/home/brew-build/brew/sbin:$HOME/.cargo/bin:$PATH
export HOMEBREW_DEVELOPER=1
export HOMEBREW_USE_RUBY_FROM_PATH=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export LD_LIBRARY_PATH=/home/brew-build/brew/opt/libxml2/lib:$LD_LIBRARY_PATH
source $HOME/.cargo/env
```

### 快速验证

```bash
# 检查工具链
python3.13 --version    # Python 3.13.2
node --version          # v22.12.0
go version              # go1.23.4 linux/loong64
rustc --version         # 1.94.1
cargo --version         # 1.94.1
```

---

## 📊 Phase 1 完成成果

### 总览

| 指标 | 数值 |
|------|------|
| **总包数** | 64 个 |
| **新增包** | 19 个 |
| **Formula 文件** | 28 个 |
| **构建成功率** | 100% |

### 按类别统计

| 类别 | 数量 | 关键包 |
|------|------|--------|
| 开发工具 | 20 | gdb, emacs, ninja, ccache, binutils |
| 编辑器 | 4 | emacs, micro, nano, bat |
| Shell/终端 | 5 | fish, zsh, tmux, zoxide, starship |
| 搜索工具 | 4 | fd, fzf, ripgrep, eza |
| 系统库 | 10 | gmp, oniguruma, berkeley-db@5 |

---

## 🔧 核心技术方案

### 1. 架构识别修复

```ruby
# 在 Formula 中添加
 cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
 args << "--build=#{cpu}-unknown-linux-gnu"
```

### 2. config.sub 自动更新

```bash
# 脚本位置: ~/scripts/fix-autotools.sh
# 使用方式:
~/scripts/fix-autotools.sh <source_directory>

# 手动更新:
wget -O config/sub \
  "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD"
```

### 3. 关键修复记录

| 问题 | 包 | 解决方案 |
|------|-----|----------|
| termcap 类型冲突 | zsh | 修改 configure.ac: `const char * const *test = boolcodes` |
| emacs 复杂依赖 | emacs | `--without-x --without-gnutls --without-tree-sitter` |
| gdb 脚本依赖 | gdb | `--without-guile --without-python` |
| unzip 构建失败 | - | 使用系统 unzip + shim |
| gmp 源码失败 | - | 使用系统库复制 |

---

## 📦 常用构建模式

### Rust 项目 (cargo)

```bash
# 适用于: fd, bat, ripgrep, fish, zoxide, starship, eza
cargo build --release
bin.install "target/release/<binary>"
```

### Go 项目

```bash
# 适用于: fzf, micro
go build -ldflags "-s -w" -o <output>
```

### Autotools 项目

```bash
# 适用于: emacs, gdb, zsh, nano, htop, tmux
~/scripts/fix-autotools.sh .
./configure --prefix=#{prefix} --build=loongarch64-unknown-linux-gnu
make
make install
```

### CMake 项目

```bash
# 适用于: ccache
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
cmake --install build
```

---

## 🚀 下一轮构建计划 (Phase 2)

### 建议目标

1. **继续扩展独立包** - 目标: 80+ 包
2. **创建 bottles** - 二进制分发
3. **完善 CI/CD** - 自动化测试
4. **文档完善** - 用户指南

### 候选包队列

| 优先级 | 包名 | 类型 |
|--------|------|------|
| P0 | rust, go (更新) | 语言运行时 |
| P1 | llvm, clang | 编译器 |
| P2 | redis, postgresql | 数据库 |
| P3 | nginx, caddy | Web 服务器 |

---

## 📚 相关资源

- **GitHub**: https://github.com/HougeLangley/homebrew-loong64
- **CI 文档**: docs/CI_ARCHITECTURE.md
- **构建状态**: docs/BUILD_STATUS.md
- **自动化脚本**: ~/scripts/fix-autotools.sh

---

> **Phase 1 完成！** 64 个包全部就绪，准备进入 Phase 2。
