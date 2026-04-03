#!/bin/bash
# 双编译机容器化构建系统
# 基于 systemd-nspawn + AOSC OS buildkit
# 
# 构建流程:
# 1. 下载 buildkit
# 2. 检查包依赖
# 3. 进入容器安装依赖 (oma)
# 4. 容器内构建
# 5. 出包 (bottle)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# 编译机配置
COMPILER1="192.168.50.244"
COMPILER2="10.86.7.42"
USER="houge"
SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=10"

# 容器配置
CONTAINER_NAME="homebrew-build"
CONTAINER_PATH="/var/lib/machines/${CONTAINER_NAME}"
BUILDKIT_URL="https://mirrors.tuna.tsinghua.edu.cn/anthon/aosc-os/os-loongarch64/buildkit/aosc-os_buildkit_20260312_loongarch64.tar.xz"
BUILDKIT_FILE="aosc-os_buildkit_20260312_loongarch64.tar.xz"

# Homebrew 配置
BREW_PREFIX="/home/brew-build/homebrew"
BREW_CELLAR="/home/brew-build/homebrew/Cellar"
BREW_REPOSITORY="/home/brew-build/homebrew"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${GREEN}[DUAL-BUILD]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
step() { echo -e "${CYAN}[STEP]${NC} $1"; }

# 显示 Banner
show_banner() {
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║         双编译机容器化构建系统 (Buildkit + nspawn)            ║"
    echo "║                                                              ║"
    echo "║  编译机 #1: $COMPILER1                           ║"
    echo "║  编译机 #2: $COMPILER2                            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
}

# 检查编译机连接
check_compiler() {
    local host="$1"
    info "检查编译机 $host 连接..."
    
    if ssh $SSH_OPTS "$USER@$host" "echo OK" &>/dev/null; then
        log "✓ 编译机 $host 可用"
        return 0
    else
        error "✗ 编译机 $host 不可用"
        return 1
    fi
}

# 步骤1: 下载 buildkit
download_buildkit() {
    local host="$1"
    step "[$host] 步骤1/5: 下载 buildkit"
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        mkdir -p ~/buildkit
        cd ~/buildkit
        
        if [[ -f '$BUILDKIT_FILE' ]] && [[ -s '$BUILDKIT_FILE' ]]; then
            echo 'Buildkit 已存在，跳过下载'
            ls -lh '$BUILDKIT_FILE'
        else
            echo '下载 buildkit (约 714MB)...'
            wget --progress=bar:force '$BUILDKIT_URL' -O '$BUILDKIT_FILE' 2>&1 | tail -3
            echo '下载完成'
        fi
    "
}

# 步骤2: 设置/验证容器
setup_container() {
    local host="$1"
    step "[$host] 步骤2/5: 设置容器"
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        
        # 检查容器是否存在
        if [[ -d '$CONTAINER_PATH' ]] && [[ -f '$CONTAINER_PATH/bin/bash' ]]; then
            echo '容器已存在，验证状态...'
            if sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- /bin/echo 'OK' 2>/dev/null; then
                echo '✓ 容器状态正常'
                exit 0
            fi
            echo '容器损坏，重新创建...'
            sudo rm -rf '$CONTAINER_PATH'
        fi
        
        echo '创建容器...'
        sudo mkdir -p '$CONTAINER_PATH'
        
        echo '解压 buildkit...'
        cd ~/buildkit
        sudo tar -xJf '$BUILDKIT_FILE' -C '$CONTAINER_PATH' --exclude='./run' --exclude='./lock' 2>&1 | tail -3
        
        # 配置容器
        echo '配置容器...'
        sudo mkdir -p '$CONTAINER_PATH'/home/brew-build
        sudo mkdir -p '$CONTAINER_PATH'/var/cache/oma
        
        # DNS
        echo 'nameserver 223.5.5.5' | sudo tee '$CONTAINER_PATH'/etc/resolv.conf >/dev/null
        echo 'nameserver 223.6.6.6' | sudo tee -a '$CONTAINER_PATH'/etc/resolv.conf >/dev/null
        
        # 创建用户
        sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- \
            /bin/bash -c 'useradd -m -d /home/brew-build -s /bin/bash brew-build 2>/dev/null || true'
        
        # 配置 sudo
        echo 'brew-build ALL=(ALL) NOPASSWD:ALL' | sudo tee '$CONTAINER_PATH'/etc/sudoers.d/brew-build >/dev/null
        
        echo '✓ 容器设置完成'
    "
}

# 步骤3: 检查依赖
check_dependencies() {
    local host="$1"
    local package="$2"
    
    step "[$host] 步骤3/5: 检查 $package 的依赖"
    
    # 获取 formula 依赖
    local deps=$(ssh $SSH_OPTS "$USER@$host" "
        cd ~/homebrew-loong64 2>/dev/null || cd ~
        if [[ -f Formula/${package}.rb ]]; then
            grep -E 'depends_on' Formula/${package}.rb 2>/dev/null | \
                sed 's/.*depends_on//' | \
                tr -d '\"' | tr -d \"'\" | \
                awk '{print \$1}' | sort -u
        fi
    ")
    
    echo "$deps"
}

# Homebrew 依赖名映射到 AOSC OS 包名
map_dep_to_oma() {
    local dep="$1"
    case "$dep" in
        openssl|openssl@3) echo "openssl" ;;
        ncurses) echo "ncurses" ;;
        gmp) echo "gmp" ;;
        mpfr) echo "mpfr" ;;
        mpc) echo "mpc" ;;
        zlib) echo "zlib" ;;
        bzip2) echo "bzip2" ;;
        xz) echo "xz" ;;
        readline) echo "readline" ;;
        libffi) echo "libffi" ;;
        gdbm) echo "gdbm" ;;
        libxml2) echo "libxml2" ;;
        libxslt) echo "libxslt" ;;
        curl) echo "curl" ;;
        expat) echo "expat" ;;
        gettext) echo "gettext" ;;
        perl) echo "perl" ;;
        python3|python@3*) echo "python-3" ;;
        ruby) echo "ruby" ;;
        node|nodejs) echo "nodejs" ;;
        go|golang) echo "go" ;;
        rust) echo "rustc" ;;
        git) echo "git" ;;
        cmake) echo "cmake" ;;
        ninja) echo "ninja" ;;
        pkg-config|pkgconf) echo "pkgconf" ;;
        autoconf) echo "autoconf" ;;
        automake) echo "automake" ;;
        libtool) echo "libtool" ;;
        m4) echo "m4" ;;
        flex) echo "flex" ;;
        bison) echo "bison" ;;
        make) echo "make" ;;
        gcc) echo "gcc" ;;
        binutils) echo "binutils" ;;
        patch) echo "patch" ;;
        diffutils) echo "diffutils" ;;
        coreutils) echo "coreutils" ;;
        findutils) echo "findutils" ;;
        grep) echo "grep" ;;
        sed) echo "sed" ;;
        gawk) echo "gawk" ;;
        gzip) echo "gzip" ;;
        tar) echo "tar" ;;
        unzip) echo "unzip" ;;
        zip) echo "zip" ;;
        wget) echo "wget" ;;
        ca-certificates) echo "ca-certs" ;;
        *) echo "" ;;
    esac
}

# 步骤4: 在容器中安装依赖
install_deps() {
    local host="$1"
    local deps="$2"
    
    step "[$host] 步骤4/5: 安装依赖"
    
    if [[ -z "$deps" ]]; then
        info "没有额外依赖需要安装"
        return 0
    fi
    
    # 转换依赖
    local oma_deps=""
    for dep in $deps; do
        local mapped=$(map_dep_to_oma "$dep")
        if [[ -n "$mapped" ]]; then
            oma_deps="$oma_deps $mapped"
        fi
    done
    
    # 去重
    oma_deps=$(echo "$oma_deps" | tr ' ' '\n' | sort -u | tr '\n' ' ')
    
    if [[ -z "$oma_deps" ]]; then
        info "没有可映射的 AOSC OS 依赖"
        return 0
    fi
    
    info "将安装依赖: $oma_deps"
    
    # 在容器中安装
    ssh $SSH_OPTS "$USER@$host" "
        sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- \
            oma install -y $oma_deps 2>&1 | tail -15
    "
}

# 步骤5: 构建包
build_package() {
    local host="$1"
    local package="$2"
    local log_file="$3"
    
    step "[$host] 步骤5/5: 构建 $package"
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        mkdir -p \$(dirname '$log_file')
        
        # 同步 Formula 到编译机
        mkdir -p ~/homebrew-loong64/Formula
    " 2>/dev/null || true
    
    # 同步 Formula 文件
    scp $SSH_OPTS "${REPO_ROOT}/Formula/${package}.rb" "$USER@$host:~/homebrew-loong64/Formula/" 2>/dev/null || true
    
    # 在容器内构建
    ssh $SSH_OPTS "$USER@$host" "
        sudo systemd-nspawn -D '$CONTAINER_PATH' \
            --user brew-build \
            --bind /home/houge:/host-home \
            --setenv=HOME=/home/brew-build \
            --setenv=HOMEBREW_NO_AUTO_UPDATE=1 \
            --setenv=HOMEBREW_BUILD_FROM_SOURCE=1 \
            --setenv=HOMEBREW_NO_INSTALL_CLEANUP=1 \
            --setenv=PATH=/host-home/brew-build/homebrew/bin:/host-home/brew-build/homebrew/sbin:/usr/bin:/bin \
            --setenv=HOMEBREW_PREFIX=/host-home/brew-build/homebrew \
            --setenv=HOMEBREW_CELLAR=/host-home/brew-build/homebrew/Cellar \
            --setenv=HOMEBREW_REPOSITORY=/host-home/brew-build/homebrew \
            --quiet \
            -- /bin/bash -c '
                export HOME=/home/brew-build
                
                echo \"========================================\"
                echo \"开始构建: $package\"
                echo \"时间: \$(date)\"
                echo \"========================================\"
                
                # 构建
                if brew install --build-bottle /host-home/homebrew-loong64/Formula/${package}.rb 2>&1; then
                    echo \"\"
                    echo \"BUILD_SUCCESS: $package\"
                    
                    # 创建 bottle
                    mkdir -p /host-home/brew-bottles/loong64
                    cd /host-home/brew-bottles
                    brew bottle --json --root-url=\"https://homebrewloongarch64.site/bottles/loong64\" $package 2>&1 || true
                    
                    # 移动 bottle
                    for f in *.tar.gz; do
                        if [[ -f \"\$f\" ]]; then
                            mv \"\$f\" loong64/ 2>/dev/null || true
                            echo \"BOTTLE: \$f\"
                        fi
                    done
                    rm -f *.json
                    
                    # 卸载
                    brew uninstall $package 2>/dev/null || true
                    
                    exit 0
                else
                    echo \"BUILD_FAILED: $package\"
                    exit 1
                fi
            ' 2>&1 | tee '$log_file'
    "
    
    local result=$?
    
    if [[ $result -eq 0 ]]; then
        log "✓ $package 构建成功"
    else
        error "✗ $package 构建失败"
    fi
    
    return $result
}

# 完整构建流程
build_single() {
    local host="$1"
    local package="$2"
    local log_dir="$3"
    
    local log_file="${log_dir}/${package}-$(date +%Y%m%d-%H%M%S).log"
    
    log "========================================"
    log "开始构建: $package @ $host"
    log "日志: $log_file"
    log "========================================"
    
    # 5个步骤
    download_buildkit "$host"
    setup_container "$host"
    local deps=$(check_dependencies "$host" "$package")
    [[ -n "$deps" ]] && install_deps "$host" "$deps"
    build_package "$host" "$package" "$log_file"
    
    local result=$?
    
    log "========================================"
    if [[ $result -eq 0 ]]; then
        log "✓ $package 构建完成"
    else
        error "✗ $package 构建失败"
    fi
    log "========================================"
    
    return $result
}

# 双机并行构建
build_parallel() {
    local packages=("$@")
    local total=${#packages[@]}
    local half=$(( (total + 1) / 2 ))
    
    log ""
    log "╔══════════════════════════════════════════════════════════════╗"
    log "║                    启动双机并行构建                           ║"
    log "║                                                              ║"
    log "║  总包数: $total                                                  ║"
    log "║  编译机 #1 ($COMPILER1): 包 1-$half                          ║"
    log "║  编译机 #2 ($COMPILER2): 包 $((half+1))-$total                           ║"
    log "╚══════════════════════════════════════════════════════════════╝"
    log ""
    
    # 分割任务
    local COMPILER1_PACKAGES=(${packages[@]:0:half})
    local COMPILER2_PACKAGES=(${packages[@]:half})
    
    # 编译机1构建
    if [[ ${#COMPILER1_PACKAGES[@]} -gt 0 ]]; then
        log "在编译机 #1 启动构建 (${#COMPILER1_PACKAGES[@]} 个包)..."
        for pkg in "${COMPILER1_PACKAGES[@]}"; do
            (build_single "$COMPILER1" "$pkg" "~/brew-logs") &
        done
    fi
    
    # 编译机2构建
    if [[ ${#COMPILER2_PACKAGES[@]} -gt 0 ]]; then
        log "在编译机 #2 启动构建 (${#COMPILER2_PACKAGES[@]} 个包)..."
        for pkg in "${COMPILER2_PACKAGES[@]}"; do
            (build_single "$COMPILER2" "$pkg" "~/brew-logs") &
        done
    fi
    
    # 等待所有后台任务完成
    wait
    
    log ""
    log "========================================"
    log "双机并行构建完成"
    log "========================================"
}

# 收集 bottles
collect_bottles() {
    log "收集 bottles..."
    
    mkdir -p ./collected-bottles
    
    for host in $COMPILER1 $COMPILER2; do
        info "从 $host 收集 bottles..."
        scp $SSH_OPTS "$USER@$host:~/brew-bottles/loong64/*.tar.gz" ./collected-bottles/ 2>/dev/null || true
    done
    
    local count=$(ls ./collected-bottles/*.tar.gz 2>/dev/null | wc -l)
    log "收集完成: $count 个 bottles"
    ls -lh ./collected-bottles/*.tar.gz 2>/dev/null || true
}

# 显示状态
show_status() {
    log "========================================"
    log "双编译机容器状态"
    log "========================================"
    
    for host in $COMPILER1 $COMPILER2; do
        echo ""
        info "编译机: $host"
        
        # 检查连接
        if ssh $SSH_OPTS "$USER@$host" "echo OK" &>/dev/null; then
            echo "  连接状态: ✓ 正常"
        else
            echo "  连接状态: ✗ 无法连接"
            continue
        fi
        
        # 容器状态
        if ssh $SSH_OPTS "$USER@$host" "sudo systemd-nspawn -D /var/lib/machines/homebrew-build --quiet --user root -- /bin/echo 'OK'" &>/dev/null; then
            echo "  容器状态: ✓ 正常"
        else
            echo "  容器状态: ✗ 异常"
        fi
        
        # Bottles 数量
        local bottle_count=$(ssh $SSH_OPTS "$USER@$host" "ls ~/brew-bottles/loong64/*.tar.gz 2>/dev/null | wc -l" 2>/dev/null || echo "0")
        echo "  Bottles: $bottle_count"
    done
    
    echo ""
}

# 清理容器
clean_container() {
    local host="$1"
    warn "将清理 $host 的容器..."
    ssh $SSH_OPTS "$USER@$host" "sudo rm -rf '$CONTAINER_PATH'"
    log "✓ 容器已清理"
}

# 初始化编译机 (一次性设置)
init_compiler() {
    local host="$1"
    
    log "初始化编译机 $host..."
    
    check_compiler "$host" || return 1
    
    download_buildkit "$host"
    setup_container "$host"
    
    log "✓ 编译机 $host 初始化完成"
}

# 初始化两台编译机
init_both() {
    show_banner
    
    log "初始化两台编译机..."
    
    init_compiler "$COMPILER1"
    init_compiler "$COMPILER2"
    
    log ""
    log "========================================"
    log "✓ 双编译机初始化完成"
    log "========================================"
}

# 显示帮助
show_help() {
    cat << 'EOF'
双编译机容器化构建系统

用法: dual-container-build.sh [命令] [选项]

命令:
    init [主机]        初始化编译机 (下载 buildkit + 设置容器)
    build [主机] [包]  构建单个包
    batch [包...]      并行构建多个包 (自动分配到两台编译机)
    all                构建所有 Formula
    status             查看编译机状态
    collect            收集 bottles
    clean [主机]       清理容器

示例:
    # 初始化两台编译机
    ./dual-container-build.sh init

    # 构建单个包
    ./dual-container-build.sh build 192.168.50.244 curl

    # 并行构建多个包
    ./dual-container-build.sh batch curl wget git

    # 构建所有包
    ./dual-container-build.sh all

    # 查看状态
    ./dual-container-build.sh status

EOF
}

# 主函数
main() {
    local cmd="${1:-}"
    local arg1="${2:-}"
    local arg2="${3:-}"
    
    case "$cmd" in
        init)
            if [[ -z "$arg1" ]]; then
                init_both
            else
                init_compiler "$arg1"
            fi
            ;;
        build)
            if [[ -z "$arg1" || -z "$arg2" ]]; then
                error "用法: $0 build [主机] [包名]"
                exit 1
            fi
            show_banner
            build_single "$arg1" "$arg2" "~/brew-logs"
            ;;
        batch)
            shift
            if [[ $# -eq 0 ]]; then
                error "用法: $0 batch [包名1] [包名2] ..."
                exit 1
            fi
            show_banner
            build_parallel "$@"
            ;;
        all)
            show_banner
            # 获取所有 formula
            local formulas=()
            for f in "${REPO_ROOT}"/Formula/*.rb; do
                [[ -f "$f" ]] && formulas+=("$(basename "$f" .rb)")
            done
            
            if [[ ${#formulas[@]} -eq 0 ]]; then
                error "没有找到 Formula"
                exit 1
            fi
            
            log "找到 ${#formulas[@]} 个 Formula"
            build_parallel "${formulas[@]}"
            ;;
        status)
            show_status
            ;;
        collect)
            collect_bottles
            ;;
        clean)
            if [[ -z "$arg1" ]]; then
                error "用法: $0 clean [主机]"
                exit 1
            fi
            clean_container "$arg1"
            ;;
        *)
            show_help
            ;;
    esac
}

main "$@"
