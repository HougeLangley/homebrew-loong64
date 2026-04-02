#!/bin/bash
# Phase 4 Batch Builder - 扩展构建系统
# 目标: 从 90+ 包扩展到 100+ 包

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PHASE4_LOG="${HOME}/brew-logs/phase4-$(date +%Y%m%d).log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SUCCESS=()
FAILED=()
SKIPPED=()

log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1" | tee -a "$PHASE4_LOG"
}

log_ok() {
    echo -e "${GREEN}[✓]${NC} $1" | tee -a "$PHASE4_LOG"
}

log_err() {
    echo -e "${RED}[✗]${NC} $1" | tee -a "$PHASE4_LOG"
}

log_warn() {
    echo -e "${YELLOW}[!]${NC} $1" | tee -a "$PHASE4_LOG"
}

# Phase 4 候选包列表
# 格式: 包名:优先级:依赖
# 优先级: P0=关键, P1=重要, P2=一般

P0_PACKAGES=(
    "rust:语言运行时:"
    "go:语言运行时:"
    "python@3.13:语言运行时:"
    "openjdk:语言运行时:"
)

P1_PACKAGES=(
    "llvm:编译器:cmake"
    "clang:编译器:llvm"
    "postgresql:数据库:"
    "mysql:数据库:"
    "mongodb:数据库:"
    "sqlite:数据库:"
    "node:语言运行时:"
    "yarn:包管理器:node"
)

P2_PACKAGES=(
    "imagemagick:图像处理:"
    "ffmpeg:多媒体:"
    "pandoc:文档工具:"
    "graphviz:图形工具:"
    "doxygen:文档工具:"
    "shellcheck:代码检查:"
    "shfmt:代码格式化:"
    "tree:系统工具:"
    "parallel:系统工具:"
    "rsync:网络工具:"
    "aria2:下载工具:"
    "mc:文件管理器:"
    "ranger:文件管理器:"
    "neofetch:系统信息:"
    "btop:系统监控:"
    "glances:系统监控:"
    "lazydocker:Docker工具:"
    "lazygit:Git工具:"
    "tig:Git工具:"
    "gh:GitHub工具:"
)

build_formula() {
    local name="$1"
    local category="$2"
    local deps="$3"
    local formula_file="${REPO_ROOT}/Formula/${name}.rb"
    
    log "构建: $name (类别: $category)"
    
    # 检查是否已存在
    if [ -f "$formula_file" ]; then
        log_warn "$name 已存在，跳过创建"
    fi
    
    # 检查是否已安装
    if brew list "$name" &>/dev/null; then
        log_ok "$name 已安装"
        SKIPPED+=("$name")
        return 0
    fi
    
    # 安装依赖
    if [ -n "$deps" ]; then
        log "安装依赖: $deps"
        for dep in $(echo "$deps" | tr ',' ' '); do
            if ! brew list "$dep" &>/dev/null; then
                brew install "$dep" 2>&1 | tee -a "$PHASE4_LOG" || true
            fi
        done
    fi
    
    # 尝试安装
    if [ -f "$formula_file" ]; then
        if brew install --build-from-source "$formula_file" 2>&1 | tee -a "$PHASE4_LOG"; then
            log_ok "$name 构建成功"
            
            # 运行测试
            if brew test "$name" 2>&1 | tee -a "$PHASE4_LOG"; then
                log_ok "$name 测试通过"
            else
                log_warn "$name 测试失败 (非致命)"
            fi
            
            SUCCESS+=("$name")
            return 0
        else
            log_err "$name 构建失败"
            FAILED+=("$name")
            return 1
        fi
    else
        log_warn "$name formula 不存在"
        FAILED+=("$name")
        return 1
    fi
}

run_batch() {
    local priority="$1"
    shift
    local packages=("$@")
    
    log "========================================"
    log "执行 $priority 优先级批量构建"
    log "包数量: ${#packages[@]}"
    log "========================================"
    
    for pkg_info in "${packages[@]}"; do
        IFS=':' read -r name category deps <<< "$pkg_info"
        build_formula "$name" "$category" "$deps" || true
        echo "" | tee -a "$PHASE4_LOG"
    done
}

generate_report() {
    log "========================================"
    log "Phase 4 构建报告"
    log "========================================"
    
    log_ok "成功: ${#SUCCESS[@]}"
    for pkg in "${SUCCESS[@]}"; do
        echo "  ✓ $pkg"
    done
    
    echo "" | tee -a "$PHASE4_LOG"
    log_err "失败: ${#FAILED[@]}"
    for pkg in "${FAILED[@]}"; do
        echo "  ✗ $pkg"
    done
    
    echo "" | tee -a "$PHASE4_LOG"
    log_warn "跳过: ${#SKIPPED[@]}"
    for pkg in "${SKIPPED[@]}"; do
        echo "  - $pkg"
    done
    
    echo "" | tee -a "$PHASE4_LOG"
    local total=$(( ${#SUCCESS[@]} + ${#FAILED[@]} + ${#SKIPPED[@]} ))
    log "总计: $total"
    
    # 计算成功率
    if [ $total -gt 0 ]; then
        local rate=$(( ${#SUCCESS[@]} * 100 / total ))
        log "成功率: ${rate}%"
    fi
    
    log "日志文件: $PHASE4_LOG"
}

show_help() {
    cat << EOF
Phase 4 Batch Builder

用法: $0 [选项]

选项:
    -h, --help          显示帮助
    -p0                 仅构建 P0 (关键) 包
    -p1                 构建 P0 + P1 (关键 + 重要) 包
    -p2                 构建所有包 (P0 + P1 + P2)
    -a, --all           同 -p2
    -f, --formula NAME  构建指定 formula
    -l, --list          列出候选包
    -r, --report        生成报告

示例:
    $0 -p0              构建关键包
    $0 -p1              构建关键和重要包
    $0 -f redis         构建 redis
    $0 -l               列出所有候选包

EOF
}

list_packages() {
    echo "P0 - 关键包 (${#P0_PACKAGES[@]}):"
    for pkg in "${P0_PACKAGES[@]}"; do
        IFS=':' read -r name category deps <<< "$pkg"
        echo "  - $name ($category)"
    done
    
    echo ""
    echo "P1 - 重要包 (${#P1_PACKAGES[@]}):"
    for pkg in "${P1_PACKAGES[@]}"; do
        IFS=':' read -r name category deps <<< "$pkg"
        echo "  - $name ($category)"
    done
    
    echo ""
    echo "P2 - 一般包 (${#P2_PACKAGES[@]}):"
    for pkg in "${P2_PACKAGES[@]}"; do
        IFS=':' read -r name category deps <<< "$pkg"
        echo "  - $name ($category)"
    done
    
    echo ""
    local total=$(( ${#P0_PACKAGES[@]} + ${#P1_PACKAGES[@]} + ${#P2_PACKAGES[@]} ))
    echo "总计: $total 个候选包"
}

main() {
    mkdir -p "$(dirname "$PHASE4_LOG")"
    
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        -l|--list)
            list_packages
            exit 0
            ;;
        -p0)
            log "Phase 4: 构建关键包 (P0)"
            run_batch "P0" "${P0_PACKAGES[@]}"
            ;;
        -p1)
            log "Phase 4: 构建关键和重要包 (P0 + P1)"
            run_batch "P0" "${P0_PACKAGES[@]}"
            run_batch "P1" "${P1_PACKAGES[@]}"
            ;;
        -p2|-a|--all)
            log "Phase 4: 构建所有包"
            run_batch "P0" "${P0_PACKAGES[@]}"
            run_batch "P1" "${P1_PACKAGES[@]}"
            run_batch "P2" "${P2_PACKAGES[@]}"
            ;;
        -f|--formula)
            if [ -z "${2:-}" ]; then
                log_err "请指定 formula 名称"
                exit 1
            fi
            build_formula "$2" "manual" ""
            ;;
        -r|--report)
            generate_report
            exit 0
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
    
    generate_report
}

trap generate_report EXIT

main "$@"
