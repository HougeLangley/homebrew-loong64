#!/bin/bash
# Dual Compiler Parallel Build System
# 同时在两台编译机上构建

set -e

COMPILER1="192.168.50.244"
COMPILER2="10.86.7.42"
USER="houge"

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[DUAL-BUILD]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查编译机连接
check_compilers() {
    log "检查编译机连接..."
    
    if ssh -o ConnectTimeout=5 "$USER@$COMPILER1" "echo OK" &>/dev/null; then
        log "✓ 编译机 #1 ($COMPILER1) 可用"
        COMPILER1_OK=1
    else
        log_error "✗ 编译机 #1 ($COMPILER1) 不可用"
        COMPILER1_OK=0
    fi
    
    if ssh -o ConnectTimeout=5 "$USER@$COMPILER2" "echo OK" &>/dev/null; then
        log "✓ 编译机 #2 ($COMPILER2) 可用"
        COMPILER2_OK=1
    else
        log_error "✗ 编译机 #2 ($COMPILER2) 不可用"
        COMPILER2_OK=0
    fi
    
    if [[ $COMPILER1_OK -eq 0 && $COMPILER2_OK -eq 0 ]]; then
        log_error "两台编译机都不可用！"
        exit 1
    fi
}

# 部署构建脚本
deploy_scripts() {
    log "部署构建脚本到编译机..."
    
    for host in $COMPILER1 $COMPILER2; do
        log "部署到 $host..."
        
        ssh "$USER@$host" "mkdir -p ~/dual-build/Formula ~/brew-bottles/loong64 ~/brew-logs" 2>/dev/null
        
        # 同步 Formula
        scp Formula/*.rb "$USER@$host:~/dual-build/Formula/" 2>/dev/null || true
        
        # 创建构建脚本
        cat > /tmp/build-worker.sh << 'WORKERSCRIPT'
#!/bin/bash
PKG="$1"
LOG_FILE="$HOME/brew-logs/${PKG}-$(date +%Y%m%d-%H%M%S).log"

source /home/brew-build/setup-homebrew-env.sh
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_BUILD_FROM_SOURCE=1

cd ~/dual-build

# 卸载已存在的版本
brew uninstall "$PKG" 2>/dev/null || true

# 构建
if brew install --build-bottle "Formula/${PKG}.rb" >"$LOG_FILE" 2>&1; then
    echo "SUCCESS: $PKG"
    
    # 创建 bottle
    cd ~/brew-bottles
    brew bottle --json --root-url="https://homebrewloongarch64.site/bottles/loong64" "$PKG" >>"$LOG_FILE" 2>&1 || true
    
    # 移动 bottle
    for f in *.tar.gz; do
        if [[ -f "$f" ]]; then
            mv "$f" loong64/
            echo "BOTTLE: $f"
        fi
    done
    rm -f *.json
    
    brew uninstall "$PKG" 2>/dev/null || true
    exit 0
else
    echo "FAILED: $PKG"
    exit 1
fi
WORKERSCRIPT
        
        scp /tmp/build-worker.sh "$USER@$host:~/dual-build/" 2>/dev/null
        ssh "$USER@$host" "chmod +x ~/dual-build/build-worker.sh" 2>/dev/null
    done
    
    log "部署完成"
}

# 分配任务并启动构建
start_parallel_build() {
    local formulas=($@)
    local total=${#formulas[@]}
    local half=$(( (total + 1) / 2 ))
    
    log "========================================"
    log "启动并行构建"
    log "总包数: $total"
    log "编译机 #1: 包 1-$half"
    log "编译机 #2: 包 $((half+1))-$total"
    log "========================================"
    
    # 分割任务
    COMPILER1_PACKAGES=(${formulas[@]:0:half})
    COMPILER2_PACKAGES=(${formulas[@]:half})
    
    # 在编译机 #1 上启动构建
    if [[ $COMPILER1_OK -eq 1 && ${#COMPILER1_PACKAGES[@]} -gt 0 ]]; then
        log "在编译机 #1 启动构建 (${#COMPILER1_PACKAGES[@]} 个包)..."
        
        ssh "$USER@$COMPILER1" "
            rm -f ~/dual-build/summary.log
            for pkg in ${COMPILER1_PACKAGES[*]}; do
                echo \"Building: \\$pkg\"
                ~/dual-build/build-worker.sh \"\$pkg\" 2>&1 | tail -1
            done > ~/dual-build/summary.log 2>&1 &
            echo \$! > ~/dual-build/build.pid
        " 2>/dev/null
    fi
    
    # 在编译机 #2 上启动构建
    if [[ $COMPILER2_OK -eq 1 && ${#COMPILER2_PACKAGES[@]} -gt 0 ]]; then
        log "在编译机 #2 启动构建 (${#COMPILER2_PACKAGES[@]} 个包)..."
        
        ssh "$USER@$COMPILER2" "
            rm -f ~/dual-build/summary.log
            for pkg in ${COMPILER2_PACKAGES[*]}; do
                echo \"Building: \\$pkg\"
                ~/dual-build/build-worker.sh \"\$pkg\" 2>&1 | tail -1
            done > ~/dual-build/summary.log 2>&1 &
            echo \$! > ~/dual-build/build.pid
        " 2>/dev/null
    fi
    
    log "构建已在两台编译机后台启动"
    log "监控命令:"
    log "  ssh $USER@$COMPILER1 'tail -f ~/dual-build/summary.log'"
    log "  ssh $USER@$COMPILER2 'tail -f ~/dual-build/summary.log'"
}

# 收集 bottles
collect_bottles() {
    log "收集 bottles..."
    
    mkdir -p ./collected-bottles
    
    for host in $COMPILER1 $COMPILER2; do
        log "从 $host 收集 bottles..."
        scp "$USER@$host:~/brew-bottles/loong64/*.tar.gz" ./collected-bottles/ 2>/dev/null || true
    done
    
    local count=$(ls ./collected-bottles/*.tar.gz 2>/dev/null | wc -l)
    log "收集完成: $count 个 bottles"
    ls -lh ./collected-bottles/*.tar.gz 2>/dev/null || true
}

# 显示状态
show_status() {
    log "========================================"
    log "构建状态"
    log "========================================"
    
    for host in $COMPILER1 $COMPILER2; do
        echo ""
        echo "编译机: $host"
        echo "进程:"
        ssh "$USER@$host" "ps aux | grep 'build-worker\|brew install' | grep -v grep | wc -l" 2>/dev/null || echo "0"
        echo "Bottles:"
        ssh "$USER@$host" "ls ~/brew-bottles/loong64/*.tar.gz 2>/dev/null | wc -l" 2>/dev/null || echo "0"
    done
}

# 主函数
main() {
    case "${1:-}" in
        check)
            check_compilers
            ;;
        deploy)
            deploy_scripts
            ;;
        build)
            check_compilers
            deploy_scripts
            
            # 获取所有 formula
            FORMULAS=($(ls Formula/*.rb 2>/dev/null | xargs -n1 basename -s .rb))
            
            if [[ ${#FORMULAS[@]} -eq 0 ]]; then
                log_error "没有找到 formula"
                exit 1
            fi
            
            start_parallel_build "${FORMULAS[@]}"
            ;;
        collect)
            collect_bottles
            ;;
        status)
            show_status
            ;;
        *)
            cat << EOF
Dual Compiler Parallel Build System

用法: $0 [命令]

命令:
    check    检查编译机连接
    deploy   部署构建脚本
    build    启动并行构建
    collect  收集 bottles
    status   查看构建状态

示例:
    $0 check      # 检查编译机
    $0 build      # 开始并行构建
    $0 status     # 查看状态
    $0 collect    # 收集结果

EOF
            ;;
    esac
}

main "$@"
