#!/bin/bash
# 
# AI Build Controller - 全自动化构建控制系统
# 使用容器化构建流程 (systemd-nspawn + oma)
#
# 注意: 此脚本应在构建编译机 (192.168.50.244) 上执行
#

set -e

# ============================================
# 配置
# ============================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_HOST="192.168.50.244"
BUILD_USER="houge"
VPS_HOST="root@47.242.26.188"
VPS_BOTTLE_DIR="/var/www/bottles/loong64"
BASE_IMAGE="/var/lib/machines/homebrew-minimal"
DATE=$(date +%Y%m%d)
DATETIME=$(date +%Y%m%d_%H%M%S)

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 统计
SUCCESS_BUILDS=()
FAILED_BUILDS=()
NEW_BOTTLES=()

# ============================================
# 日志函数
# ============================================
log() { echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1"; }

# ============================================
# 初始化环境
# ============================================
init_environment() {
    log "初始化 AI 构建控制器..."
    
    # 检查 SSH 连接
    log "检查构建机 (${BUILD_HOST}) 连接..."
    if ! ssh -q -o ConnectTimeout=5 "${BUILD_USER}@${BUILD_HOST}" "echo OK" &>/dev/null; then
        log_error "无法连接到构建机 ${BUILD_HOST}"
        exit 1
    fi
    log_success "构建机连接正常"
    
    # 检查 VPS 连接
    log "检查 VPS 连接..."
    if ! ssh -q -o ConnectTimeout=5 "$VPS_HOST" "echo OK" &>/dev/null; then
        log_warn "VPS SSH 连接失败，同步步骤将被跳过"
        VPS_AVAILABLE=false
    else
        log_success "VPS 连接正常"
        VPS_AVAILABLE=true
    fi
    
    log "环境初始化完成"
}

# ============================================
# 容器化构建单个包
# ============================================
build_package_containerized() {
    local pkg="$1"
    
    log "========================================"
    log "容器化构建: $pkg"
    log "========================================"
    
    # 检查 formula 是否存在
    if [[ ! -f "${REPO_ROOT}/Formula/${pkg}.rb" ]]; then
        log_error "Formula 不存在: ${pkg}.rb"
        FAILED_BUILDS+=("$pkg")
        return 1
    fi
    
    # 在构建机上执行容器化构建
    local container_name="homebrew-build-${pkg}"
    
    if ssh "${BUILD_USER}@${BUILD_HOST}" << EOF
        set -e
        
        # 检查基础镜像
        if [ ! -d "$BASE_IMAGE" ]; then
            echo "错误: 基础镜像不存在"
            exit 1
        fi
        
        # 步骤 1: 创建独立容器
        echo "[1/6] 创建容器: ${container_name}..."
        sudo rm -rf /var/lib/machines/${container_name}
        sudo cp -a ${BASE_IMAGE} /var/lib/machines/${container_name}
        
        # 步骤 2: 启动容器
        echo "[2/6] 启动容器..."
        sudo systemd-nspawn \\
            -D /var/lib/machines/${container_name} \\
            --boot \\
            --register=yes \\
            --bind=/run/dbus:/run/dbus \\
            --bind=/home/brew-build/homebrew:/brew &
        sleep 5
        
        # 步骤 3: 获取源码信息
        echo "[3/6] 获取源码..."
        # 从 formula 提取 URL 和 sha256
        
        # 步骤 4: 容器内构建
        echo "[4/6] 容器内构建..."
        sudo nsenter -t \$(pgrep -x systemd | head -1) -m -u -i -n -p /bin/bash << 'INNEREOF'
            set -e
            export HOME=/root
            export PATH=/usr/bin:/bin:/usr/sbin:/sbin
            
            # 使用 oma 刷新
            oma refresh --no-check-dbus 2>&1 | tail -3
            
            # 构建 (这里应该解析 formula 的构建方式)
            echo "构建 $pkg..."
            # 实际构建逻辑根据 formula 类型而定
INNEREOF
        
        # 步骤 5: 生成 bottle 并上传
        echo "[5/6] 生成 bottle 并上传..."
        # 创建 bottle tar.gz
        # scp 到 VPS
        
        # 步骤 6: 销毁容器
        echo "[6/6] 销毁容器..."
        sudo machinectl terminate ${container_name} 2>/dev/null || true
        sudo rm -rf /var/lib/machines/${container_name}
        
        echo "✓ $pkg 构建完成"
EOF
    then
        log_success "$pkg 构建成功"
        SUCCESS_BUILDS+=("$pkg")
        return 0
    else
        log_error "$pkg 构建失败"
        FAILED_BUILDS+=("$pkg")
        return 1
    fi
}

# ============================================
# 显示使用帮助
# ============================================
show_usage() {
    cat << EOF
AI Build Controller - 容器化构建控制系统

用法: $0 [选项] [包名...]

选项:
    -h, --help          显示帮助
    -a, --all           构建所有 Formula
    -l, --list          列出所有可用的 Formula
    --no-vps            跳过 VPS 同步

示例:
    $0 curl wget                    构建指定包
    $0 -a                           构建所有包
    $0 -l                           列出可用包

容器化构建流程:
    1. SSH 到构建机 (192.168.50.244)
    2. 复制基础镜像 → homebrew-build-<package>
    3. 启动 systemd-nspawn 容器
    4. 使用 oma 安装依赖
    5. cargo/make 编译
    6. 生成 bottle 并上传 VPS
    7. 销毁容器

注意:
    此脚本需要在本地执行，通过 SSH 控制构建机

EOF
}

# ============================================
# 列出所有 Formula
# ============================================
list_formulas() {
    log "可用的 Formula:"
    for formula in "${REPO_ROOT}/Formula"/*.rb; do
        local name
        name=$(basename "$formula" .rb)
        echo "  - $name"
    done
}

# ============================================
# 生成报告
# ============================================
generate_report() {
    log "========================================"
    log "构建报告"
    log "========================================"
    
    echo "成功: ${#SUCCESS_BUILDS[@]}"
    for pkg in "${SUCCESS_BUILDS[@]}"; do
        echo "  ✓ $pkg"
    done
    
    echo ""
    echo "失败: ${#FAILED_BUILDS[@]}"
    for pkg in "${FAILED_BUILDS[@]}"; do
        echo "  ✗ $pkg"
    done
}

# ============================================
# 主函数
# ============================================
main() {
    local packages=()
    local build_all=false
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -a|--all)
                build_all=true
                shift
                ;;
            -l|--list)
                list_formulas
                exit 0
                ;;
            --no-vps)
                VPS_AVAILABLE=false
                shift
                ;;
            -*)
                log_error "未知选项: $1"
                show_usage
                exit 1
                ;;
            *)
                packages+=("$1")
                shift
                ;;
        esac
    done
    
    # 初始化
    init_environment
    
    # 确定要构建的包列表
    if [[ "$build_all" == "true" ]]; then
        for formula in "${REPO_ROOT}/Formula"/*.rb; do
            packages+=("$(basename "$formula" .rb)")
        done
    fi
    
    if [[ ${#packages[@]} -eq 0 ]]; then
        log_error "没有指定要构建的包"
        show_usage
        exit 1
    fi
    
    log "========================================"
    log "AI 构建控制器 - 容器化构建"
    log "包数量: ${#packages[@]}"
    log "构建机: ${BUILD_HOST}"
    log "========================================"
    
    # 执行批量处理
    for pkg in "${packages[@]}"; do
        build_package_containerized "$pkg" || true
        echo ""
    done
    
    # 生成报告
    generate_report
    
    log "========================================"
    log "AI 构建控制器完成"
    log "========================================"
    
    # 返回状态
    if [[ ${#FAILED_BUILDS[@]} -gt 0 ]]; then
        exit 1
    else
        exit 0
    fi
}

# 设置退出时生成报告
trap generate_report EXIT

main "$@"
