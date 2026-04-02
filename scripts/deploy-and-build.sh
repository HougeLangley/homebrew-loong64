#!/bin/bash
# Phase 4 Deployment Script - 部署到编译机并启动构建
# 用法: ./deploy-and-build.sh [编译机IP] [优先级]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# 编译机配置
COMPILER1="192.168.50.244"
COMPILER2="10.86.7.42"
USER="houge"
SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=10"

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[DEPLOY]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查编译机连接
check_compiler() {
    local host="$1"
    log "检查编译机 $host 连接..."
    
    if ssh $SSH_OPTS "$USER@$host" "echo OK" &>/dev/null; then
        log "✓ 编译机 $host 可用"
        return 0
    else
        log_error "✗ 编译机 $host 不可用"
        return 1
    fi
}

# 部署构建系统到编译机
deploy_to_compiler() {
    local host="$1"
    log "部署构建系统到 $host..."
    
    # 创建远程目录
    ssh $SSH_OPTS "$USER@$host" "mkdir -p ~/homebrew-loong64-deploy"
    
    # 同步关键脚本
    log "同步 AI 构建控制器..."
    rsync -avz --progress \
        "$REPO_ROOT/scripts/ai-build-controller.sh" \
        "$REPO_ROOT/scripts/vps-sync-service.sh" \
        "$REPO_ROOT/scripts/phase4-builder.sh" \
        "$REPO_ROOT/Makefile" \
        "$USER@$host:~/homebrew-loong64-deploy/"
    
    # 同步 Formula
    log "同步 Formula..."
    rsync -avz --progress \
        "$REPO_ROOT/Formula/" \
        "$USER@$host:~/homebrew-loong64-deploy/Formula/"
    
    log "✓ 部署完成到 $host"
}

# 在编译机上启动构建
start_build_on_compiler() {
    local host="$1"
    local priority="${2:-p0}"
    
    log "在 $host 启动 Phase 4 $priority 构建..."
    
    # 设置环境并启动构建
    ssh $SSH_OPTS "$USER@$host" "
        export HOMEBREW_DEVELOPER=1
        export HOMEBREW_NO_AUTO_UPDATE=1
        export HOMEBREW_NO_INSTALL_FROM_API=1
        export HOMEBREW_BUILD_FROM_SOURCE=1
        export PATH=/home/brew-build/homebrew/bin:/home/brew-build/homebrew/sbin:\$PATH
        
        cd ~/homebrew-loong64-deploy
        
        echo '========================================'
        echo 'Phase 4 构建开始'
        echo '时间: \$(date)'
        echo '编译机: $host'
        echo '优先级: $priority'
        echo '========================================'
        
        # 启动构建
        ./phase4-builder.sh -$priority 2>&1 | tee ~/phase4-build-\$(date +%Y%m%d-%H%M%S).log
        
        echo '========================================'
        echo '构建完成'
        echo '========================================'
    "
}

# 主部署流程
main() {
    local target_host="${1:-}"
    local priority="${2:-p0}"
    
    log "========================================"
    log "Phase 4 部署与构建系统"
    log "========================================"
    
    # 如果没有指定编译机，检查两台
    if [[ -z "$target_host" ]]; then
        log "未指定编译机，自动检测可用编译机..."
        
        if check_compiler "$COMPILER1"; then
            target_host="$COMPILER1"
        elif check_compiler "$COMPILER2"; then
            target_host="$COMPILER2"
        else
            log_error "两台编译机都不可用！"
            log "请检查:"
            log "  1. VPN 连接"
            log "  2. SSH 密钥配置"
            log "  3. 编译机状态"
            exit 1
        fi
    else
        if ! check_compiler "$target_host"; then
            log_error "指定的编译机 $target_host 不可用"
            exit 1
        fi
    fi
    
    log "选择编译机: $target_host"
    log "构建优先级: $priority"
    
    # 部署
    deploy_to_compiler "$target_host"
    
    # 启动构建
    log "准备启动构建..."
    log "构建将在后台运行，日志保存在编译机上"
    log ""
    log "查看日志命令:"
    log "  ssh $USER@$host 'tail -f ~/phase4-build-*.log'"
    log ""
    
    read -p "确认开始构建? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        start_build_on_compiler "$target_host" "$priority"
    else
        log "已取消构建"
        log "构建系统已部署到 $target_host:~/homebrew-loong64-deploy/"
        log "可以手动登录启动: ssh $USER@$target_host"
    fi
}

# 显示帮助
show_help() {
    cat << EOF
Phase 4 部署与构建脚本

用法: $0 [选项] [编译机] [优先级]

参数:
  编译机    目标编译机 IP (可选，自动检测)
  优先级    p0|p1|p2 (默认: p0)

示例:
  $0                          # 自动选择编译机，构建 P0
  $0 192.168.50.244           # 使用指定编译机
  $0 192.168.50.244 p1        # 构建 P0+P1
  $0 auto p2                  # 自动选择，构建所有

优先级说明:
  p0 - 关键包: rust, go, python, openjdk
  p1 - 重要包: llvm, postgresql, mysql, node
  p2 - 一般包: ffmpeg, imagemagick, pandoc 等

编译机:
  编译机 #1: 192.168.50.244 (推荐，公钥免密码)
  编译机 #2: 10.86.7.42

EOF
}

case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac
