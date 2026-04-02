# AI 全自动化构建系统文档

## 概述

本系统实现了从源码构建到 Bottle 分发再到 GitHub 推送的**完整闭环自动化**。

## 完整闭环流程

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   源码构建   │ → │  Bottle构建  │ → │  VPS同步    │ → │ GitHub推送   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       │                  │                  │                  │
       ▼                  ▼                  ▼                  ▼
   Formula/*.rb      *.tar.gz         index.json        Release/Commits
```

## 核心组件

### 1. AI Build Controller (`scripts/ai-build-controller.sh`)

**功能**: 一站式构建控制器，执行完整闭环

**用法**:
```bash
# 构建单个包
./scripts/ai-build-controller.sh curl

# 构建多个包
./scripts/ai-build-controller.sh curl wget redis

# 构建所有包
./scripts/ai-build-controller.sh --all

# 仅构建，不同步/推送
./scripts/ai-build-controller.sh curl --no-vps --no-github

# 列出可用包
./scripts/ai-build-controller.sh --list
```

**完整流程**:
1. 初始化环境 (检查 SSH/GitHub 连接)
2. 从源码构建包
3. 运行测试
4. 构建 Bottle
5. 同步到 VPS
6. 推送到 GitHub
7. 更新索引

### 2. VPS Sync Service (`scripts/vps-sync-service.sh`)

**功能**: 后台持续同步服务

**用法**:
```bash
# 启动后台服务
./scripts/vps-sync-service.sh start

# 停止服务
./scripts/vps-sync-service.sh stop

# 查看状态
./scripts/vps-sync-service.sh status

# 立即同步一次
./scripts/vps-sync-service.sh sync-now
```

**特性**:
- 每60秒检查一次新 bottle
- 自动生成和更新索引文件
- 自动设置远程文件权限

### 3. Phase 4 Builder (`scripts/phase4-builder.sh`)

**功能**: 扩展到 100+ 包的批量构建

**用法**:
```bash
# 构建关键包 (P0)
./scripts/phase4-builder.sh -p0

# 构建关键+重要包 (P0+P1)
./scripts/phase4-builder.sh -p1

# 构建所有候选包
./scripts/phase4-builder.sh -p2

# 列出候选包
./scripts/phase4-builder.sh -l
```

**候选包队列**:
- **P0 (关键)**: rust, go, python@3.13, openjdk
- **P1 (重要)**: llvm, clang, postgresql, mysql, mongodb, sqlite, node
- **P2 (一般)**: imagemagick, ffmpeg, pandoc, 等20+个工具

### 4. GitHub Actions 工作流

#### Release Bottles (`.github/workflows/release-bottles.yml`)

**触发条件**:
- 手动触发 (`workflow_dispatch`)
- Formula 变更推送
- 每天凌晨3点自动运行

**任务**:
1. **build-and-release**: 分批构建 bottle 并创建 Release
2. **release**: 合并 manifest 并生成发布说明
3. **sync-to-vps**: 自动同步到 VPS
4. **update-formula-bottles**: 更新 Formula 中的 bottle SHA

**并行策略**:
- 4个并行批次同时构建
- 每批约13-14个包
- 总构建时间约3小时

## Makefile 快捷命令

```bash
# 基础命令
make install        # 安装 tap
make test           # 测试 formulas
make audit          # 审计 formulas
make build          # 批量构建

# AI 构建控制器
make ai-build PKG=redis         # 构建指定包
make ai-build-all               # 构建所有包
make bottle PKG=curl            # 构建 bottle
make sync                       # 同步到 VPS

# Phase 4 扩展
make phase4-p0                  # 关键包
make phase4-p1                  # 关键+重要包
make phase4-all                 # 所有候选包
```

## 目录结构

```
/home/brewbuilder/
├── bottles/
│   └── loong64/
│       ├── *.tar.gz          # Bottle 文件
│       └── index.json        # 索引文件
├── logs/
│   ├── controller-*.log      # 控制器日志
│   └── phase4-*.log          # Phase4 日志
└── homebrew/                  # Homebrew 安装

/var/www/homebrewloongarch64.site/bottles/loong64/  # VPS 目录
```

## 配置说明

### 环境变量

在 `~/.bashrc` 或 `~/.zshrc` 中添加:

```bash
# Homebrew 开发环境
export HOMEBREW_DEVELOPER=1
export HOMEBREW_USE_RUBY_FROM_PATH=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUILD_FROM_SOURCE=1
export PATH=/home/brew-build/homebrew/bin:/home/brew-build/homebrew/sbin:$PATH
```

### SSH 配置

确保编译机可以无密码 SSH 到 VPS:

```bash
# 在编译机上执行
ssh-copy-id root@47.242.26.188

# 测试连接
ssh root@47.242.26.188 "echo OK"
```

### GitHub Token

在 GitHub Actions 中自动配置，本地推送需要:

```bash
git remote set-url origin https://<token>@github.com/HougeLangley/homebrew-loong64.git
```

## 使用示例

### 场景1: 添加新包并发布

```bash
# 1. 创建 formula
vim Formula/myapp.rb

# 2. 使用 AI 控制器完整发布
make ai-build PKG=myapp

# 完成! 控制器会自动:
# - 构建源码
# - 创建 bottle
# - 同步到 VPS
# - 推送到 GitHub
```

### 场景2: 批量构建所有包

```bash
# 方法1: 使用 AI 控制器
make ai-build-all

# 方法2: 使用 GitHub Actions
# 访问: Actions → Release Bottles → Run workflow
```

### 场景3: Phase 4 扩展构建

```bash
# 先构建关键包
make phase4-p0

# 如果成功，继续构建重要包
make phase4-p1

# 最后构建所有包
make phase4-all
```

### 场景4: 后台持续同步

```bash
# 在编译机上启动同步服务
./scripts/vps-sync-service.sh start

# 查看状态
./scripts/vps-sync-service.sh status

# 服务会自动监控并同步新 bottle
```

## 故障排查

### VPS 连接失败

```bash
# 检查 SSH 连接
ssh -v root@47.242.26.188

# 检查 VPS 目录权限
ssh root@47.242.26.188 "ls -la /var/www/"
```

### Bottle 构建失败

```bash
# 查看详细日志
tail -f ~/brew-logs/controller-$(date +%Y%m%d).log

# 单独测试构建
brew install --build-bottle --verbose ./Formula/curl.rb
```

### GitHub 推送失败

```bash
# 检查远程仓库
git remote -v

# 检查权限
git push --dry-run
```

## 监控和日志

### 实时查看构建日志

```bash
# AI 控制器日志
tail -f ~/brew-logs/controller-$(date +%Y%m%d).log

# Phase4 构建日志
tail -f ~/brew-logs/phase4-$(date +%Y%m%d).log

# VPS 同步服务日志
tail -f /tmp/vps-sync-service.log
```

### 查看构建统计

```bash
# 成功构建的包
ls ~/brew-bottles/loong64/*.tar.gz | wc -l

# 查看索引
cat ~/brew-bottles/loong64/index.json | jq '.bottles | length'
```

## 扩展计划

根据路线图，接下来的工作:

1. **Week 1**: 完成 800 formulae
   - 使用 AI 控制器批量构建
   - 所有编译器独立 (GCC, LLVM, Rust, Go)

2. **Week 2**: 完成 1800 formulae
   - 多媒体库 (ffmpeg, OpenCV)
   - 科学计算 (numpy, scipy, pandas)

3. **Week 3**: 完成 2500 formulae
   - 常用工具补全
   - 性能优化

4. **Week 4**: 完成 3000+ formulae
   - Linuxbrew PR 提交
   - 社区建设

## 总结

本系统实现了**完全自动化的构建-发布闭环**:

✅ **构建**: 从源码自动构建  
✅ **Bottle**: 自动创建二进制分发包  
✅ **同步**: 自动同步到 VPS  
✅ **推送**: 自动推送到 GitHub  
✅ **索引**: 自动更新索引文件  

**只需一个命令，完成所有工作!**
