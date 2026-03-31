#!/bin/bash
#
# Homebrew Loong64 CI Runner 设置脚本
# 
# 用途: 在 LoongArch64 机器上配置 GitHub Actions 自托管 Runner
# 环境: AOSC OS / LoongArch Linux
#

set -e

# 配置变量
REPO_URL="https://github.com/HougeLangley/homebrew-loong64"
RUNNER_USER="brew-runner"
RUNNER_DIR="/home/${RUNNER_USER}/actions-runner"
CONTAINER_NAME="brew-ci"
CONTAINER_DIR="/var/lib/machines/${CONTAINER_NAME}"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 root 权限
check_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "请使用 root 权限运行此脚本"
        exit 1
    fi
}

# 检查架构
check_arch() {
    ARCH=$(uname -m)
    if [ "$ARCH" != "loongarch64" ]; then
        log_warn "当前架构是 $ARCH，不是 loongarch64"
        log_warn "此脚本专为 LoongArch64 设计"
        read -p "是否继续? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    log_info "检测到架构: $ARCH"
}

# 安装依赖
install_dependencies() {
    log_info "安装系统依赖..."
    
    # 检测发行版
    if [ -f /etc/aosc-release ]; then
        # AOSC OS
        apt-get update
        apt-get install -y \
            systemd-container \
            git \
            curl \
            wget \
            build-essential \
            ruby \
            ruby-bundler
    elif [ -f /etc/arch-release ]; then
        # Arch Linux / LoongArch Linux
        pacman -Sy --needed --noconfirm \
            systemd \
            git \
            curl \
            wget \
            base-devel \
            ruby
    else
        log_error "不支持的发行版"
        exit 1
    fi
    
    log_info "系统依赖安装完成"
}

# 创建 Runner 用户
create_runner_user() {
    log_info "创建 Runner 用户..."
    
    if id "$RUNNER_USER" &>/dev/null; then
        log_warn "用户 $RUNNER_USER 已存在"
    else
        useradd -m -s /bin/bash "$RUNNER_USER"
        log_info "用户 $RUNNER_USER 创建成功"
    fi
    
    # 配置 sudo 权限（无需密码）
    echo "$RUNNER_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$RUNNER_USER"
    chmod 440 /etc/sudoers.d/"$RUNNER_USER"
}

# 设置 systemd-nspawn 容器
setup_container() {
    log_info "设置 systemd-nspawn 容器..."
    
    if [ -d "$CONTAINER_DIR" ]; then
        log_warn "容器目录已存在: $CONTAINER_DIR"
        read -p "是否删除并重新创建? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$CONTAINER_DIR"
        else
            log_info "使用现有容器"
            return
        fi
    fi
    
    mkdir -p "$CONTAINER_DIR"
    
    # 创建基础容器
    log_info "正在创建基础容器（可能需要较长时间）..."
    if command -v pacstrap &> /dev/null; then
        # Arch Linux
        pacstrap -i "$CONTAINER_DIR" base base-devel git curl wget ruby
    elif command -v debootstrap &> /dev/null; then
        # Debian/Ubuntu/AOSC
        # 注意：LoongArch 可能需要特殊的 debootstrap 配置
        log_warn "请手动配置容器环境"
    else
        # 手动复制基础系统
        log_info "复制基础系统..."
        rsync -a /bin /usr /lib /lib64 "$CONTAINER_DIR/" 2>/dev/null || true
    fi
    
    # 配置容器
    mkdir -p "$CONTAINER_DIR"/{proc,sys,dev,run,tmp}
    
    # 创建 Runner 用户（容器内）
    systemd-nspawn -D "$CONTAINER_DIR" -u root -- \
        useradd -m -s /bin/bash "$RUNNER_USER" || true
    
    log_info "容器设置完成"
}

# 在容器内安装 Homebrew
install_homebrew_in_container() {
    log_info "在容器内安装 Homebrew..."
    
    local HB_PREFIX="/home/linuxbrew/.linuxbrew"
    
    # 创建目录结构
    systemd-nspawn -D "$CONTAINER_DIR" -u root -- \
        mkdir -p "$HB_PREFIX"
    
    # 安装 Homebrew
    systemd-nspawn -D "$CONTAINER_DIR" -u "$RUNNER_USER" -- \
        /bin/bash -c '
            export HOMEBREW_NO_INSTALL_FROM_API=1
            export HOMEBREW_NO_AUTO_UPDATE=1
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ' || {
        log_warn "Homebrew 安装可能部分失败，尝试手动配置..."
    }
    
    # 配置环境变量
    local PROFILE_FILE="$CONTAINER_DIR/home/$RUNNER_USER/.bashrc"
    cat >> "$PROFILE_FILE" << 'EOF'

# Homebrew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}"
export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

# Homebrew Loong64 优化
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
EOF
    
    log_info "Homebrew 安装完成"
}

# 下载并配置 GitHub Actions Runner
setup_github_runner() {
    log_info "设置 GitHub Actions Runner..."
    
    # 获取最新 Runner 版本
    local RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | \
        grep tag_name | cut -d '"' -f 4 | sed 's/v//')
    
    log_info "下载 Runner 版本: $RUNNER_VERSION"
    
    # 创建目录
    mkdir -p "$RUNNER_DIR"
    cd "$RUNNER_DIR"
    
    # 下载（注意：GitHub Actions Runner 可能没有 LoongArch64 官方版本）
    # 需要自行编译或使用 x86_64 版本配合 QEMU（不推荐）
    # 此处提供两种方案：
    
    log_warn "GitHub Actions Runner 官方不支持 LoongArch64"
    log_info "可选方案："
    echo "  1. 使用 actions-runner-controller (Kubernetes)"
    echo "  2. 自行编译 Runner"
    echo "  3. 使用替代方案（如 Jenkins + GitHub Webhook）"
    
    # 尝试下载 ARM64 版本（可能不兼容）
    local ARCH="arm64"
    local DOWNLOAD_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz"
    
    log_info "尝试下载: $DOWNLOAD_URL"
    curl -o actions-runner.tar.gz -L "$DOWNLOAD_URL" || {
        log_error "下载失败，需要手动获取 Runner"
        return 1
    }
    
    tar xzf actions-runner.tar.gz
    rm actions-runner.tar.gz
    
    # 修改权限
    chown -R "$RUNNER_USER:$RUNNER_USER" "$RUNNER_DIR"
    
    log_info "Runner 下载完成"
    log_warn "注意：需要手动运行 config.sh 注册到 GitHub"
}

# 创建 systemd 服务
create_systemd_service() {
    log_info "创建 systemd 服务..."
    
    cat > /etc/systemd/system/brew-ci-runner.service << EOF
[Unit]
Description=GitHub Actions Runner for Homebrew Loong64
After=network.target

[Service]
Type=simple
User=$RUNNER_USER
WorkingDirectory=$RUNNER_DIR
Environment="HOME=/home/$RUNNER_USER"
Environment="PATH=/home/linuxbrew/.linuxbrew/bin:/usr/bin:/bin"
ExecStart=$RUNNER_DIR/run.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    log_info "服务创建完成"
    log_info "启动服务: systemctl start brew-ci-runner"
    log_info "查看状态: systemctl status brew-ci-runner"
}

# 生成配置说明
print_next_steps() {
    echo
    echo "=========================================="
    echo "  Homebrew Loong64 CI Runner 设置完成"
    echo "=========================================="
    echo
    echo "下一步操作:"
    echo
    echo "1. 获取 GitHub Runner Token:"
    echo "   访问: https://github.com/HougeLangley/homebrew-loong64/settings/actions/runners"
    echo "   点击 'New self-hosted runner' 获取 token"
    echo
    echo "2. 配置 Runner:"
    echo "   cd $RUNNER_DIR"
    echo "   sudo -u $RUNNER_USER ./config.sh --url $REPO_URL --token <TOKEN>"
    echo
    echo "3. 启动 Runner:"
    echo "   sudo systemctl enable --now brew-ci-runner"
    echo
    echo "4. 验证状态:"
    echo "   sudo systemctl status brew-ci-runner"
    echo "   # 在 GitHub 页面上确认 Runner 显示为 online"
    echo
    echo "5. 测试构建:"
    echo "   sudo -u $RUNNER_USER systemd-nspawn -D $CONTAINER_DIR -u $RUNNER_USER --"
    echo "       /bin/bash -c 'brew install curl'"
    echo
    echo "重要提示:"
    echo "- 确保容器内有稳定的网络连接"
    echo "- 建议配置国内镜像源加速下载"
    echo "- 定期清理旧版本以释放磁盘空间"
    echo
    echo "故障排查:"
    echo "- Runner 日志: journalctl -u brew-ci-runner -f"
    echo "- 容器内测试: systemd-nspawn -D $CONTAINER_DIR -u $RUNNER_USER"
    echo
}

# 主函数
main() {
    echo "=========================================="
    echo "  Homebrew Loong64 CI Runner 设置脚本"
    echo "=========================================="
    echo
    
    check_root
    check_arch
    
    log_info "开始设置..."
    
    install_dependencies
    create_runner_user
    setup_container
    install_homebrew_in_container
    setup_github_runner
    create_systemd_service
    
    print_next_steps
    
    log_info "设置脚本执行完毕"
}

# 如果直接运行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main "$@"
fi
