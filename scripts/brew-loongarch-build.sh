#!/bin/bash
# brew-loongarch-build.sh - Homebrew LoongArch 自动化构建脚本
# 用法: ./brew-loongarch-build.sh <package-name> [version]
# 示例: ./brew-loongarch-build.sh dust 1.2.4

set -e

# 配置
BASE_IMAGE="/var/lib/machines/homebrew-minimal"
BREW_CELLAR="/home/brew-build/homebrew/Cellar"
VPS_HOST="root@47.242.26.188"
VPS_BOTTLE_DIR="/var/www/bottles/loong64"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查参数
if [ $# -lt 1 ]; then
    echo "用法: $0 <package-name> [version]"
    echo "示例: $0 dust 1.2.4"
    exit 1
fi

PACKAGE="$1"
VERSION="${2:-}"
CONTAINER_NAME="homebrew-build-${PACKAGE}"
CONTAINER_PATH="/var/lib/machines/${CONTAINER_NAME}"

log_info "开始构建 ${PACKAGE}..."

# 步骤 1: 分析依赖
log_info "步骤 1: 分析依赖"
if command -v brew &> /dev/null; then
    brew deps --tree "${PACKAGE}" 2>/dev/null || log_warn "无法分析依赖树"
fi

# 步骤 2: 创建容器
log_info "步骤 2: 创建容器 ${CONTAINER_NAME}"
if [ ! -d "$BASE_IMAGE" ]; then
    log_error "基础镜像不存在: $BASE_IMAGE"
    exit 1
fi

# 清理已存在的容器
if [ -d "$CONTAINER_PATH" ]; then
    log_warn "容器已存在，正在清理..."
    sudo machinectl terminate "$CONTAINER_NAME" 2>/dev/null || true
    sudo rm -rf "$CONTAINER_PATH"
fi

# 复制基础镜像
sudo cp -a "$BASE_IMAGE" "$CONTAINER_PATH"
log_info "容器创建完成"

# 步骤 3: 启动容器并构建
log_info "步骤 3: 启动容器并构建"
sudo systemd-nspawn \
    -D "$CONTAINER_PATH" \
    --boot \
    --register=yes \
    --bind=/run/dbus:/run/dbus \
    --bind=/home/brew-build/homebrew:/brew &

# 等待容器启动
sleep 5

# 获取容器 systemd PID
SYSTEMD_PID=$(pgrep -x systemd | head -1)

# 在容器内执行构建
sudo nsenter -t "$SYSTEMD_PID" -m -u -i -n -p /bin/bash << EOF
    set -e
    export HOME=/root
    export PATH=/usr/bin:/bin:/usr/sbin:/sbin
    
    # 刷新 oma
    log_info() {
        echo "[INFO] \$1"
    }
    
    log_info "刷新包数据库..."
    oma refresh
    
    # 安装 Rust 工具链（如果是 Rust 项目）
    if [ -f "/brew/Cellar/${PACKAGE}/${VERSION}/.rust_project" ] || \
       curl -sI "https://github.com/${PACKAGE}/${PACKAGE}" 2>/dev/null | grep -q "rust"; then
        log_info "安装 Rust 工具链..."
        oma install --no-check-dbus -y rustc cargo
    fi
    
    # 下载源码
    cd /tmp
    
    # 尝试从 formula 获取 URL
    if [ -f "/brew/Library/Taps/loongarch/homebrew-loong64/Formula/${PACKAGE}.rb" ]; then
        URL=$(grep -o 'url "[^"]*"' "/brew/Library/Taps/loongarch/homebrew-loong64/Formula/${PACKAGE}.rb" | head -1 | sed 's/url "//;s/"$//')
        log_info "从 formula 获取 URL: \$URL"
    fi
    
    # 根据项目类型构建
    if [ -d "${PACKAGE}-*" ]; then
        cd ${PACKAGE}-*
        
        # Rust 项目
        if [ -f "Cargo.toml" ]; then
            log_info "检测到 Rust 项目，使用 cargo 构建..."
            cargo build --release
            
            # 安装到 Cellar
            mkdir -p "/brew/Cellar/${PACKAGE}/${VERSION}/bin"
            find target/release -maxdepth 1 -type f -executable -exec cp {} "/brew/Cellar/${PACKAGE}/${VERSION}/bin/" \;
        fi
        
        # 创建 bottle
        cd "/brew/Cellar/${PACKAGE}/${VERSION}"
        tar czf "/tmp/${PACKAGE}--${VERSION}.loongarch64_linux.bottle.tar.gz" .
        log_info "Bottle 创建完成"
        ls -lh "/tmp/${PACKAGE}--${VERSION}.loongarch64_linux.bottle.tar.gz"
    fi
EOF

# 步骤 4: 上传到 VPS
log_info "步骤 4: 上传到 VPS"
BOTTLE_FILE="/tmp/${PACKAGE}--${VERSION}.loongarch64_linux.bottle.tar.gz"

if [ -f "$BOTTLE_FILE" ]; then
    scp "$BOTTLE_FILE" "${VPS_HOST}:${VPS_BOTTLE_DIR}/"
    log_info "上传完成"
else
    log_error "Bottle 文件不存在: $BOTTLE_FILE"
    exit 1
fi

# 步骤 5: 销毁容器
log_info "步骤 5: 销毁容器"
sudo machinectl terminate "$CONTAINER_NAME" 2>/dev/null || true
sudo rm -rf "$CONTAINER_PATH"

# 清理临时文件
rm -f "$BOTTLE_FILE"

log_info "${PACKAGE} 构建完成！"
