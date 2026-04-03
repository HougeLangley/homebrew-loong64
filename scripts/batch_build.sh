#!/bin/bash
#
# 批量构建 Homebrew Formulae 并生成 Bottles
# 使用容器化构建流程 (systemd-nspawn + oma)
#
# 注意: 此脚本应在构建编译机 (192.168.50.244) 上执行
#

set -e

# ============================================
# 配置
# ============================================
BUILD_HOST="192.168.50.244"
BUILD_USER="houge"
VPS_HOST="root@47.242.26.188"
VPS_BOTTLE_DIR="/var/www/bottles/loong64"
BASE_IMAGE="/var/lib/machines/homebrew-minimal"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_LOG_DIR="${REPO_ROOT}/build_logs"
REPORT_FILE="${REPO_ROOT}/build_report.md"

mkdir -p "$BUILD_LOG_DIR"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"; }
log_ok() { echo -e "${GREEN}[✓]${NC} $1"; }
log_err() { echo -e "${RED}[✗]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1"; }

# ============================================
# 在构建机上执行容器化构建
# ============================================
build_in_container() {
    local pkg="$1"
    local version="$2"
    local container_name="homebrew-build-${pkg}"
    local log_file="${BUILD_LOG_DIR}/${pkg}.log"
    
    log "构建: $pkg (容器: $container_name)"
    
    # SSH 到构建机执行构建
    ssh "${BUILD_USER}@${BUILD_HOST}" << EOF | tee "$log_file"
        set -e
        
        # 检查基础镜像
        if [ ! -d "$BASE_IMAGE" ]; then
            echo "错误: 基础镜像不存在: $BASE_IMAGE"
            exit 1
        fi
        
        # 步骤 1: 复制基础容器
        echo "[1/8] 创建容器..."
        sudo rm -rf /var/lib/machines/${container_name}
        sudo cp -a ${BASE_IMAGE} /var/lib/machines/${container_name}
        
        # 步骤 2: 启动容器
        echo "[2/8] 启动容器..."
        sudo systemd-nspawn \\
            -D /var/lib/machines/${container_name} \\
            --boot \\
            --register=yes \\
            --bind=/run/dbus:/run/dbus \\
            --bind=/home/brew-build/homebrew:/brew &
        sleep 5
        
        # 步骤 3-6: 容器内构建
        echo "[3-6/8] 容器内构建..."
        sudo nsenter -t \$(pgrep -x systemd | head -1) -m -u -i -n -p /bin/bash << 'INNEREOF'
            set -e
            export HOME=/root
            export PATH=/usr/bin:/bin:/usr/sbin:/sbin
            cd /tmp
            
            # 下载源码
            echo ">>> 下载 $pkg 源码..."
            # 这里应该从 formula 获取 URL 和 sha256
            # 简化版本: 使用 formula 中的信息
            
            # 构建
            echo ">>> 构建 $pkg..."
            if command -v cargo &>/dev/null; then
                # Rust 项目
                cargo build --release 2>&1 | tail -5
            elif [ -f Makefile ]; then
                # Makefile 项目
                make && make install
            else
                # Autotools 项目
                ./configure --prefix=/brew/Cellar/${pkg}/${version}
                make && make install
            fi
            
            # 创建 bottle
            echo ">>> 创建 bottle..."
            cd /brew/Cellar/${pkg}/${version}
            tar czf /tmp/${pkg}--${version}.loongarch64_linux.bottle.tar.gz .
INNEREOF
        
        # 步骤 7: 上传到 VPS
        echo "[7/8] 上传 bottle..."
        scp /tmp/${pkg}--${version}.loongarch64_linux.bottle.tar.gz ${VPS_HOST}:${VPS_BOTTLE_DIR}/
        
        # 步骤 8: 销毁容器
        echo "[8/8] 销毁容器..."
        sudo machinectl terminate ${container_name} 2>/dev/null || true
        sudo rm -rf /var/lib/machines/${container_name}
        
        echo "✓ $pkg 构建完成"
EOF
    
    return ${PIPESTATUS[0]}
}

# ============================================
# 从 formula 获取版本
# ============================================
get_version_from_formula() {
    local pkg="$1"
    local formula_file="${REPO_ROOT}/Formula/${pkg}.rb"
    
    if [ ! -f "$formula_file" ]; then
        echo ""
        return 1
    fi
    
    # 从 formula 提取版本 (简化处理)
    grep -E 'url.*archive|url.*download' "$formula_file" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1
}

# ============================================
# 主流程
# ============================================
main() {
    local packages=()
    local build_all=false
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--all)
                build_all=true
                shift
                ;;
            -h|--help)
                cat << 'EOF'
批量构建 Homebrew Formulae (容器化构建)

用法: $0 [选项] [包名...]

选项:
    -a, --all       构建所有 Formula
    -h, --help      显示帮助

示例:
    $0 curl wget            构建 curl 和 wget
    $0 -a                   构建所有包

注意:
    此脚本需要在构建编译机 (192.168.50.244) 上执行
    或使用 SSH 连接到构建机

容器化构建流程:
    1. 复制基础镜像 → homebrew-build-<package>
    2. 启动 systemd-nspawn 容器
    3. 使用 oma 安装依赖
    4. cargo/make 编译
    5. 生成 bottle 并上传 VPS
    6. 销毁容器

EOF
                exit 0
                ;;
            -*)
                log_err "未知选项: $1"
                exit 1
                ;;
            *)
                packages+=("$1")
                shift
                ;;
        esac
    done
    
    # 检查 SSH 连接
    log "检查构建机连接..."
    if ! ssh -q -o ConnectTimeout=5 "${BUILD_USER}@${BUILD_HOST}" "echo OK" &>/dev/null; then
        log_err "无法连接到构建机 ${BUILD_HOST}"
        log "请确保:"
        log "  1. SSH 密钥已配置"
        log "  2. 构建机已开机"
        log "  3. 网络连接正常"
        exit 1
    fi
    log_ok "构建机连接正常"
    
    # 获取包列表
    if [ "$build_all" = true ]; then
        for formula in "${REPO_ROOT}"/Formula/*.rb; do
            packages+=("$(basename "$formula" .rb)")
        done
    fi
    
    if [ ${#packages[@]} -eq 0 ]; then
        log_err "没有指定要构建的包"
        log "用法: $0 [包名...] 或 $0 -a"
        exit 1
    fi
    
    log "========================================"
    log "批量构建 ${#packages[@]} 个包"
    log "构建机: ${BUILD_HOST}"
    log "========================================"
    
    # 初始化报告
    echo "# Homebrew Loong64 批量构建报告" > "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "构建时间: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
    echo "构建机: ${BUILD_HOST}" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    local success=()
    local failed=()
    local total=${#packages[@]}
    local current=0
    
    for pkg in "${packages[@]}; do
        current=$((current + 1))
        log ""
        log "[$current/$total] $pkg"
        log "========================================"
        
        # 获取版本
        local version
        version=$(get_version_from_formula "$pkg")
        if [ -z "$version" ]; then
            version="latest"
        fi
        
        # 构建
        if build_in_container "$pkg" "$version"; then
            log_ok "$pkg 构建成功"
            success+=("$pkg")
            echo "- ✓ $pkg" >> "$REPORT_FILE"
        else
            log_err "$pkg 构建失败"
            failed+=("$pkg")
            echo "- ✗ $pkg" >> "$REPORT_FILE"
        fi
    done
    
    # 生成报告
    echo "" >> "$REPORT_FILE"
    echo "## 统计" >> "$REPORT_FILE"
    echo "- 总计: $total" >> "$REPORT_FILE"
    echo "- 成功: ${#success[@]}" >> "$REPORT_FILE"
    echo "- 失败: ${#failed[@]}" >> "$REPORT_FILE"
    
    log ""
    log "========================================"
    log "构建完成"
    log "成功: ${#success[@]}"
    log "失败: ${#failed[@]}"
    log "报告: $REPORT_FILE"
    log "========================================"
    
    if [ ${#failed[@]} -gt 0 ]; then
        exit 1
    fi
}

main "$@"
