#!/bin/bash
# Buildkit 容器构建系统
# 基于 systemd-nspawn 的双编译机构建环境
# 
# 流程:
# 1. 下载 buildkit
# 2. 检查依赖
# 3. 进入容器安装依赖
# 4. 容器内构建
# 5. 出包

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

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[BUILDKIT]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
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

# 下载 buildkit
download_buildkit() {
    local host="$1"
    log "在 $host 下载 buildkit..."
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        mkdir -p ~/buildkit
        cd ~/buildkit
        
        if [[ -f '$BUILDKIT_FILE' ]]; then
            echo 'Buildkit 已存在，跳过下载'
        else
            echo '下载 buildkit...'
            wget --progress=bar:force '$BUILDKIT_URL' -O '$BUILDKIT_FILE' 2>&1 | tail -5
        fi
        
        echo 'Buildkit 准备就绪'
        ls -lh '$BUILDKIT_FILE'
    "
}

# 设置 systemd-nspawn 容器
setup_container() {
    local host="$1"
    log "在 $host 设置 systemd-nspawn 容器..."
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        
        # 检查是否已有容器
        if [[ -d '$CONTAINER_PATH' ]]; then
            echo '容器已存在，检查状态...'
            if systemd-nspawn -D '$CONTAINER_PATH' --test &>/dev/null; then
                echo '容器状态正常'
                exit 0
            else
                echo '容器损坏，重新创建...'
                sudo rm -rf '$CONTAINER_PATH'
            fi
        fi
        
        # 解压 buildkit 到容器目录
        echo '创建容器目录...'
        sudo mkdir -p '$CONTAINER_PATH'
        
        echo '解压 buildkit (可能需要几分钟)...'
        cd ~/buildkit
        sudo tar -xJf '$BUILDKIT_FILE' -C '$CONTAINER_PATH' --strip-components=1 2>&1 | tail -3
        
        # 配置容器
        echo '配置容器...'
        
        # 创建必要的挂载点
        sudo mkdir -p '$CONTAINER_PATH'/home/brew-build
        sudo mkdir -p '$CONTAINER_PATH'/var/cache/oma
        
        # 配置 DNS
        echo 'nameserver 223.5.5.5' | sudo tee '$CONTAINER_PATH'/etc/resolv.conf >/dev/null
        echo 'nameserver 223.6.6.6' | sudo tee -a '$CONTAINER_PATH'/etc/resolv.conf >/dev/null
        
        # 配置主机名
        echo 'homebrew-build' | sudo tee '$CONTAINER_PATH'/etc/hostname >/dev/null
        
        # 创建 brew-build 用户
        sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- \
            useradd -m -d /home/brew-build -s /bin/bash brew-build 2>/dev/null || true
        
        # 更新 oma 数据库
        echo '更新 oma 数据库...'
        sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- \
            oma refresh 2>&1 | tail -3 || true
        
        echo '容器设置完成'
    "
}

# 检查包的依赖
check_dependencies() {
    local host="$1"
    local package="$2"
    
    log "检查 $package 的依赖..."
    
    # 获取 formula 中的依赖信息
    local deps=$(ssh $SSH_OPTS "$USER@$host" "
        cd ~/homebrew-loong64 2>/dev/null || cd ~
        if [[ -f Formula/${package}.rb ]]; then
            # 提取 depends_on 信息
            grep -E 'depends_on' Formula/${package}.rb 2>/dev/null | sed 's/.*depends_on//' | tr -d '"' | tr -d "'" | awk '{print \$1}' | sort -u
        fi
    ")
    
    echo "$deps"
}

# 在容器中安装依赖
install_deps_in_container() {
    local host="$1"
    local deps="$2"
    
    log "在容器中安装依赖..."
    
    # 将 Homebrew 依赖名映射到 AOSC OS 包名
    local oma_deps=""
    for dep in $deps; do
        case "$dep" in
            openssl|openssl@3) oma_deps="$oma_deps openssl" ;;
            ncurses) oma_deps="$oma_deps ncurses" ;;
            gmp) oma_deps="$oma_deps gmp" ;;
            mpfr) oma_deps="$oma_deps mpfr" ;;
            mpc) oma_deps="$oma_deps mpc" ;;
            zlib) oma_deps="$oma_deps zlib" ;;
            bzip2) oma_deps="$oma_deps bzip2" ;;
            xz) oma_deps="$oma_deps xz" ;;
            readline) oma_deps="$oma_deps readline" ;;
            libffi) oma_deps="$oma_deps libffi" ;;
            gdbm) oma_deps="$oma_deps gdbm" ;;
            libxml2) oma_deps="$oma_deps libxml2" ;;
            libxslt) oma_deps="$oma_deps libxslt" ;;
            curl) oma_deps="$oma_deps curl" ;;
            expat) oma_deps="$oma_deps expat" ;;
            gettext) oma_deps="$oma_deps gettext" ;;
            perl) oma_deps="$oma_deps perl" ;;
            python3|python@3*) oma_deps="$oma_deps python-3" ;;
            ruby) oma_deps="$oma_deps ruby" ;;
            node) oma_deps="$oma_deps nodejs" ;;
            go) oma_deps="$oma_deps go" ;;
            rust) oma_deps="$oma_deps rustc" ;;
            git) oma_deps="$oma_deps git" ;;
            cmake) oma_deps="$oma_deps cmake" ;;
            ninja) oma_deps="$oma_deps ninja" ;;
            pkg-config) oma_deps="$oma-deps pkgconf" ;;
            *) log_warn "未知依赖: $dep" ;;
        esac
    done
    
    # 去重
    oma_deps=$(echo "$oma_deps" | tr ' ' '\n' | sort -u | tr '\n' ' ')
    
    if [[ -n "$oma_deps" ]]; then
        log "将安装以下依赖: $oma_deps"
        
        ssh $SSH_OPTS "$USER@$host" "
            sudo systemd-nspawn -D '$CONTAINER_PATH' --quiet --user root -- \
                oma install -y $oma_deps 2>&1 | tail -10
        "
    else
        log_info "没有需要安装的额外依赖"
    fi
}

# 构建包（在容器内）
build_package_in_container() {
    local host="$1"
    local package="$2"
    local log_file="$3"
    
    log "在容器中构建 $package..."
    
    ssh $SSH_OPTS "$USER@$host" "
        set -e
        
        # 确保日志目录存在
        mkdir -p \$(dirname '$log_file')
        
        # 在容器内执行构建
        sudo systemd-nspawn -D '$CONTAINER_PATH' \
            --user brew-build \
            --bind /home/houge:/home/brew-build \
            --bind /home/brew-build:/brew \
            --setenv=HOMEBREW_NO_AUTO_UPDATE=1 \
            --setenv=HOMEBREW_BUILD_FROM_SOURCE=1 \
            --setenv=PATH=/brew/homebrew/bin:/brew/homebrew/sbin:/usr/bin:/bin \
            --quiet \
            -- /bin/bash -c '
                export HOME=/home/brew-build
                export HOMEBREW_PREFIX=/brew/homebrew
                export HOMEBREW_CELLAR=/brew/homebrew/Cellar
                export HOMEBREW_REPOSITORY=/brew/homebrew
                
                cd /home/brew-build/homebrew-loong64 2>/dev/null || cd /home/brew-build
                
                echo \"========================================\"
                echo \"开始构建: $package\"
                echo \"时间: \$(date)\"
                echo \"========================================\"
                
                if brew install --build-bottle Formula/${package}.rb; then
                    echo \"BUILD_SUCCESS: $package\"
                    
                    # 创建 bottle
                    cd /home/brew-build/brew-bottles 2>/dev/null || mkdir -p /home/brew-build/brew-bottles && cd /home/brew-build/brew-bottles
                    brew bottle --json --root-url=\"https://homebrewloongarch64.site/bottles/loong64\" $package || true
                    
                    # 移动 bottle
                    for f in *.tar.gz; do
                        if [[ -f \"\$f\" ]]; then
                            mv \"\$f\" loong64/ 2>/dev/null || true
                            echo \"BOTTLE_CREATED: \$f\"
                        fi
                    done
                    
                    exit 0
                else
                    echo \"BUILD_FAILED: $package\"
                    exit 1
                fi
            ' 2>&1 | tee -a '$log_file'
    "
    
    return ${PIPESTATUS[0]}
}

# 完整的构建流程
build_with_container() {
    local host="$1"
    local package="$2"
    local log_dir="$3"
    
    local log_file="${log_dir}/${package}-$(date +%Y%m%d-%H%M%S).log"
    
    log "========================================"
    log "构建包: $package @ $host"
    log "日志: $log_file"
    log "========================================"
    
    # 步骤1: 下载 buildkit
    download_buildkit "$host"
    
    # 步骤2: 设置容器
    setup_container "$host"
    
    # 步骤3: 检查依赖
    local deps=$(check_dependencies "$host" "$package")
    
    # 步骤4: 安装依赖
    if [[ -n "$deps" ]]; then
        install_deps_in_container "$host" "$deps"
    fi
    
    # 步骤5: 构建
    if build_package_in_container "$host" "$package" "$log_file"; then
        log "✓ $package 构建成功"
        return 0
    else
        log_error "✗ $package 构建失败"
        return 1
    fi
}

# 显示帮助
show_help() {
    cat << 'EOF'
Buildkit 容器构建系统

用法: buildkit-builder.sh [命令] [选项]

命令:
    setup [主机]       在指定编译机设置 buildkit 容器
    build [主机] [包]  在容器中构建指定包
    batch [主机]       批量构建所有包
    deps [主机] [包]   检查包的依赖
    status [主机]      查看容器状态
    clean [主机]       清理容器

示例:
    # 在编译机1设置环境
    ./buildkit-builder.sh setup 192.168.50.244

    # 构建单个包
    ./buildkit-builder.sh build 192.168.50.244 curl

    # 批量构建
    ./buildkit-builder.sh batch 192.168.50.244

容器路径: /var/lib/machines/homebrew-build

EOF
}

# 主函数
main() {
    local cmd="${1:-}"
    local host="${2:-}"
    local package="${3:-}"
    
    case "$cmd" in
        setup)
            if [[ -z "$host" ]]; then
                # 在两台编译机上都设置
                check_compiler "$COMPILER1" && download_buildkit "$COMPILER1" && setup_container "$COMPILER1"
                check_compiler "$COMPILER2" && download_buildkit "$COMPILER2" && setup_container "$COMPILER2"
            else
                check_compiler "$host" && download_buildkit "$host" && setup_container "$host"
            fi
            ;;
        build)
            if [[ -z "$host" || -z "$package" ]]; then
                log_error "用法: $0 build [主机] [包名]"
                exit 1
            fi
            check_compiler "$host" || exit 1
            build_with_container "$host" "$package" "~/brew-logs"
            ;;
        batch)
            if [[ -z "$host" ]]; then
                log_error "用法: $0 batch [主机]"
                exit 1
            fi
            check_compiler "$host" || exit 1
            
            # 获取所有 formula
            local formulas=$(ssh $SSH_OPTS "$USER@$host" "ls ~/homebrew-loong64/Formula/*.rb 2>/dev/null | xargs -n1 basename -s .rb" 2>/dev/null)
            
            log "批量构建 ${#formulas[@]} 个包..."
            for pkg in $formulas; do
                build_with_container "$host" "$pkg" "~/brew-logs" || true
            done
            ;;
        deps)
            if [[ -z "$host" || -z "$package" ]]; then
                log_error "用法: $0 deps [主机] [包名]"
                exit 1
            fi
            check_compiler "$host" || exit 1
            local deps=$(check_dependencies "$host" "$package")
            log "依赖列表:"
            echo "$deps" | while read dep; do
                echo "  - $dep"
            done
            ;;
        status)
            if [[ -z "$host" ]]; then
                # 检查两台编译机
                for h in "$COMPILER1" "$COMPILER2"; do
                    log "检查 $h..."
                    ssh $SSH_OPTS "$USER@$h" "
                        echo '容器状态:'
                        if [[ -d '$CONTAINER_PATH' ]]; then
                            echo '  容器目录: 存在'
                            sudo systemd-nspawn -D '$CONTAINER_PATH' --test 2>&1 | head -3 || echo '  测试: 失败'
                        else
                            echo '  容器目录: 不存在'
                        fi
                        echo 'Buildkit:'
                        ls -lh ~/buildkit/'$BUILDKIT_FILE' 2>/dev/null || echo '  未下载'
                    " 2>/dev/null || log_error "  无法连接"
                done
            else
                check_compiler "$host" || exit 1
                ssh $SSH_OPTS "$USER@$host" "
                    echo '容器状态:'
                    if [[ -d '$CONTAINER_PATH' ]]; then
                        echo '  容器目录: 存在'
                        sudo systemd-nspawn -D '$CONTAINER_PATH' --test 2>&1 | head -3 || echo '  测试: 失败'
                    else
                        echo '  容器目录: 不存在'
                    fi
                "
            fi
            ;;
        clean)
            if [[ -z "$host" ]]; then
                log_error "用法: $0 clean [主机]"
                exit 1
            fi
            check_compiler "$host" || exit 1
            log_warn "将删除容器 $CONTAINER_PATH"
            ssh $SSH_OPTS "$USER@$host" "sudo rm -rf '$CONTAINER_PATH'"
            log "容器已清理"
            ;;
        *)
            show_help
            ;;
    esac
}

main "$@"
