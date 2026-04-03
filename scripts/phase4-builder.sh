#!/bin/bash
# Phase 4 Batch Builder - 容器化构建系统
# 使用 systemd-nspawn 容器在远程构建机器上构建

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PHASE4_LOG="${HOME}/brew-logs/phase4-$(date +%Y%m%d).log"

# 构建机器配置
BUILD_HOST="${BUILD_HOST:-192.168.50.244}"
BUILD_USER="${BUILD_USER:-root}"
BUILD_DIR="/root/homebrew-build"

# VPS 配置
VPS_HOST="${VPS_HOST:-47.242.26.188}"
VPS_USER="${VPS_USER:-root}"
VPS_BOTTLE_DIR="/var/www/homebrew/bottles"

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

# 检查 SSH 连接
check_ssh() {
    local host="$1"
    local user="$2"
    
    if ! ssh -q -o ConnectTimeout=5 "${user}@${host}" "echo OK" &>/dev/null; then
        log_err "无法连接到 ${user}@${host}"
        log "请确保:"
        log "  1. SSH 密钥已配置: ssh-copy-id ${user}@${host}"
        log "  2. 构建机器已开机"
        log "  3. 网络连接正常"
        return 1
    fi
    log_ok "SSH 连接正常: ${user}@${host}"
    return 0
}

# 同步 formula 到构建机器
sync_formula() {
    local name="$1"
    local formula_file="${REPO_ROOT}/Formula/${name}.rb"
    
    log "同步 formula 到构建机器: $name"
    
    if [ ! -f "$formula_file" ]; then
        log_warn "Formula 文件不存在: $formula_file"
        return 1
    fi
    
    # 创建远程目录
    ssh "${BUILD_USER}@${BUILD_HOST}" "mkdir -p ${BUILD_DIR}/Formula"
    
    # 复制 formula 文件
    scp "$formula_file" "${BUILD_USER}@${BUILD_HOST}:${BUILD_DIR}/Formula/"
    
    log_ok "Formula 同步完成: $name"
    return 0
}

# 构建单个包（在远程构建机器上使用容器）
build_in_container() {
    local name="$1"
    local category="$2"
    
    log "构建: $name (类别: $category)"
    
    # 检查 formula 是否存在
    if [ ! -f "${REPO_ROOT}/Formula/${name}.rb" ]; then
        log_warn "Formula 不存在: $name"
        FAILED+=("$name:formula_not_found")
        return 1
    fi
    
    # 同步 formula 到构建机器
    if ! sync_formula "$name"; then
        FAILED+=("$name:sync_failed")
        return 1
    fi
    
    # 在构建机器上执行容器化构建
    log "在容器内构建: $name"
    
    local build_output
    if build_output=$(ssh "${BUILD_USER}@${BUILD_HOST}" 2>&1 << EOF
set -e
cd ${BUILD_DIR}

# 创建临时容器
CONTAINER_NAME="homebrew-build-${name}-\$(date +%s)"
echo "创建容器: \$CONTAINER_NAME"

# 复制基础镜像
mkdir -p /var/lib/machines/\$CONTAINER_NAME
cp -a /var/lib/machines/homebrew-minimal/* /var/lib/machines/\$CONTAINER_NAME/

# 进入容器构建
systemd-nspawn -D /var/lib/machines/\$CONTAINER_NAME --bind=/root/homebrew-build:/home/linuxbrew/build \
    bash -c '
        export HOME=/home/linuxbrew
        export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:\${PATH}"
        eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        
        cd /home/linuxbrew/build
        
        # 安装依赖
        if grep -q "depends_on" Formula/${name}.rb; then
            echo "安装依赖..."
            DEPS=\$(grep "depends_on" Formula/${name}.rb | sed "s/.*depends_on \"\([^\"]*\)\".*/\1/" | tr "\\n" " ")
            for dep in \$DEPS; do
                if [ -f "Formula/\${dep}.rb" ]; then
                    brew install --build-from-source Formula/\${dep}.rb || true
                fi
            done
        fi
        
        # 构建
        echo "开始构建 ${name}..."
        if brew install --build-from-source Formula/${name}.rb; then
            echo "BUILD_SUCCESS"
            
            # 运行测试
            if brew test ${name} 2>/dev/null; then
                echo "TEST_SUCCESS"
            else
                echo "TEST_FAILED"
            fi
            
            # 打包 bottle
            echo "打包 bottle..."
            brew bottle --json ${name} 2>/dev/null || true
            
            # 列出生成的 bottle
            ls -la *.tar.gz 2>/dev/null || echo "NO_BOTTLE"
        else
            echo "BUILD_FAILED"
            exit 1
        fi
    '

# 复制 bottle 到 VPS
if ls /var/lib/machines/\$CONTAINER_NAME/home/linuxbrew/*.tar.gz 1>/dev/null 2>&1; then
    echo "上传 bottle 到 VPS..."
    scp /var/lib/machines/\$CONTAINER_NAME/home/linuxbrew/*.tar.gz "${VPS_USER}@${VPS_HOST}:${VPS_BOTTLE_DIR}/" || echo "UPLOAD_FAILED"
fi

# 销毁容器
echo "销毁容器..."
rm -rf /var/lib/machines/\$CONTAINER_NAME

echo "BUILD_COMPLETE"
EOF
); then
        log_ok "容器构建完成: $name"
        
        # 分析输出
        if echo "$build_output" | grep -q "BUILD_SUCCESS"; then
            if echo "$build_output" | grep -q "TEST_SUCCESS"; then
                SUCCESS+=("$name:build+test")
            elif echo "$build_output" | grep -q "TEST_FAILED"; then
                SUCCESS+=("$name:build_only")
                log_warn "$name 构建成功但测试失败"
            else
                SUCCESS+=("$name")
            fi
            return 0
        else
            log_err "$name 构建失败"
            FAILED+=("$name:build_error")
            return 1
        fi
    else
        log_err "$name 容器构建失败"
        log "错误输出: $build_output"
        FAILED+=("$name:container_error")
        return 1
    fi
}

# 本地构建（回退方案）
build_locally() {
    local name="$1"
    local category="$2"
    local formula_file="${REPO_ROOT}/Formula/${name}.rb"
    
    log "本地构建: $name (类别: $category)"
    
    # 检查是否已存在
    if [ ! -f "$formula_file" ]; then
        log_warn "$name formula 不存在"
        FAILED+=("$name")
        return 1
    fi
    
    # 尝试安装
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
}

run_batch() {
    local priority="$1"
    shift
    local packages=("$@")
    
    log "========================================"
    log "执行 $priority 优先级批量构建"
    log "包数量: ${#packages[@]}"
    log "构建机器: ${BUILD_USER}@${BUILD_HOST}"
    log "========================================"
    
    # 首先检查 SSH 连接
    if ! check_ssh "$BUILD_HOST" "$BUILD_USER"; then
        log_warn "构建机器不可用，切换到本地构建模式"
        for pkg_info in "${packages[@]}"; do
            IFS=':' read -r name category deps <<< "$pkg_info"
            build_locally "$name" "$category" "$deps" || true
            echo "" | tee -a "$PHASE4_LOG"
        done
        return
    fi
    
    for pkg_info in "${packages[@]}"; do
        IFS=':' read -r name category deps <<< "$pkg_info"
        build_in_container "$name" "$category" || true
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
Phase 4 Batch Builder - 容器化构建系统

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
    --local             强制使用本地构建模式

环境变量:
    BUILD_HOST          构建机器地址 (默认: 192.168.50.244)
    BUILD_USER          构建机器用户 (默认: root)
    VPS_HOST            VPS 地址 (默认: 47.242.26.188)
    VPS_USER            VPS 用户 (默认: root)

示例:
    $0 -p0              构建关键包
    $0 -p1              构建关键和重要包
    $0 -f redis         构建 redis
    $0 -l               列出所有候选包
    BUILD_HOST=10.0.0.5 $0 -p0    使用指定构建机器

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
            
            # 检查 SSH 连接
            if check_ssh "$BUILD_HOST" "$BUILD_USER"; then
                build_in_container "$2" "manual"
            else
                build_locally "$2" "manual"
            fi
            ;;
        -r|--report)
            generate_report
            exit 0
            ;;
        --local)
            shift
            log "强制本地构建模式"
            if [ -n "${1:-}" ]; then
                build_locally "$1" "manual"
            else
                run_batch "P0" "${P0_PACKAGES[@]}"
            fi
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
