#!/bin/bash
# AI Build Controller - 全自动化构建控制系统
# 功能: 构建 → Bottle → 同步VPS → 推送GitHub → 更新索引
# 用法: ./ai-build-controller.sh [package1] [package2] ... [--all]

set -e

# ============================================
# 配置区域
# ============================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
BOTTLE_DIR="${HOME}/brew-bottles"
LOG_DIR="${HOME}/brew-logs"
VPS_HOST="root@47.242.26.188"
VPS_BOTTLE_DIR="/var/www/homebrewloongarch64.site/bottles/loong64"
GITHUB_REPO="HougeLangley/homebrew-loong64"
GITHUB_BRANCH="main"
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
log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1" | tee -a "${LOG_DIR}/controller-${DATE}.log"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1" | tee -a "${LOG_DIR}/controller-${DATE}.log"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1" | tee -a "${LOG_DIR}/controller-${DATE}.log"
}

log_warn() {
    echo -e "${YELLOW}[!]${NC} $1" | tee -a "${LOG_DIR}/controller-${DATE}.log"
}

# ============================================
# 初始化环境
# ============================================
init_environment() {
    log "初始化 AI 构建控制器..."
    
    # 创建必要目录
    mkdir -p "$BOTTLE_DIR/loong64" "$LOG_DIR"
    
    # 检查必要环境变量
    if [[ -z "$HOMEBREW_DEVELOPER" ]]; then
        export HOMEBREW_DEVELOPER=1
    fi
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_FROM_API=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_BUILD_FROM_SOURCE=1
    
    # 检查 SSH 连接
    log "检查 VPS 连接..."
    if ! ssh -q -o ConnectTimeout=5 "$VPS_HOST" "echo OK" &>/dev/null; then
        log_warn "VPS SSH 连接失败，同步步骤将被跳过"
        VPS_AVAILABLE=false
    else
        log_success "VPS 连接正常"
        VPS_AVAILABLE=true
    fi
    
    # 检查 GitHub 权限
    log "检查 GitHub 权限..."
    if ! git remote get-url origin &>/dev/null; then
        log_warn "GitHub 仓库未配置，推送步骤将被跳过"
        GITHUB_AVAILABLE=false
    else
        log_success "GitHub 仓库已配置"
        GITHUB_AVAILABLE=true
    fi
    
    log "环境初始化完成"
}

# ============================================
# 构建单个包
# ============================================
build_package() {
    local pkg="$1"
    local log_file="${LOG_DIR}/${pkg}-${DATETIME}.log"
    
    log "开始构建: $pkg"
    
    # 检查 formula 是否存在
    if [[ ! -f "${REPO_ROOT}/Formula/${pkg}.rb" ]]; then
        log_error "Formula 不存在: ${pkg}.rb"
        FAILED_BUILDS+=("$pkg")
        return 1
    fi
    
    # 卸载已存在的版本
    if brew list "$pkg" &>/dev/null; then
        log "卸载现有版本..."
        brew uninstall "$pkg" 2>/dev/null || true
    fi
    
    # 从源码构建
    log "从源码构建 $pkg..."
    if brew install --build-from-source "${REPO_ROOT}/Formula/${pkg}.rb" 2>&1 | tee "$log_file"; then
        log_success "$pkg 构建成功"
        
        # 运行测试
        log "运行测试..."
        if brew test "$pkg" 2>&1 | tee -a "$log_file"; then
            log_success "$pkg 测试通过"
        else
            log_warn "$pkg 测试失败 (非致命)"
        fi
        
        SUCCESS_BUILDS+=("$pkg")
        return 0
    else
        log_error "$pkg 构建失败"
        FAILED_BUILDS+=("$pkg")
        return 1
    fi
}

# ============================================
# 构建 Bottle
# ============================================
build_bottle() {
    local pkg="$1"
    local log_file="${LOG_DIR}/${pkg}-${DATETIME}.log"
    
    log "构建 Bottle: $pkg"
    
    # 确保包已安装
    if ! brew list "$pkg" &>/dev/null; then
        log_error "$pkg 未安装，无法构建 bottle"
        return 1
    fi
    
    # 构建 bottle
    cd "$BOTTLE_DIR"
    
    if brew bottle --json --root-url="https://homebrewloongarch64.site/bottles/loong64" "$pkg" 2>&1 | tee -a "$log_file"; then
        # 查找生成的 bottle 文件
        local bottle_file
        bottle_file=$(ls -t *.tar.gz 2>/dev/null | head -1)
        
        if [[ -n "$bottle_file" ]]; then
            local full_path="${BOTTLE_DIR}/loong64/${bottle_file}"
            mv "$bottle_file" "$full_path"
            
            # 计算 checksum
            local sha256
            sha256=$(sha256sum "$full_path" | awk '{print $1}')
            
            # 记录到 manifest
            echo "${pkg},${sha256},${bottle_file},${DATETIME}" >> "${BOTTLE_DIR}/manifest-${DATE}.csv"
            
            log_success "Bottle 构建成功: $bottle_file"
            log "  SHA256: $sha256"
            
            NEW_BOTTLES+=("$pkg:$bottle_file:$sha256")
            
            # 清理 JSON 文件
            rm -f ./*.json
            
            return 0
        else
            log_error "Bottle 文件未找到"
            return 1
        fi
    else
        log_error "Bottle 构建失败"
        return 1
    fi
}

# ============================================
# 同步到 VPS
# ============================================
sync_to_vps() {
    local pkg="$1"
    
    if [[ "$VPS_AVAILABLE" != "true" ]]; then
        log_warn "VPS 不可用，跳过同步"
        return 1
    fi
    
    log "同步 $pkg 到 VPS..."
    
    # 找到对应的 bottle 文件
    local bottle_file
    bottle_file=$(grep "^${pkg}," "${BOTTLE_DIR}/manifest-${DATE}.csv" 2>/dev/null | tail -1 | cut -d',' -f3)
    
    if [[ -z "$bottle_file" ]]; then
        log_error "找不到 $pkg 的 bottle 文件记录"
        return 1
    fi
    
    local full_path="${BOTTLE_DIR}/loong64/${bottle_file}"
    
    if [[ ! -f "$full_path" ]]; then
        log_error "Bottle 文件不存在: $full_path"
        return 1
    fi
    
    # 同步到 VPS
    if rsync -avz --progress "$full_path" "${VPS_HOST}:${VPS_BOTTLE_DIR}/"; then
        # 更新索引
        update_vps_index
        log_success "$pkg 已同步到 VPS"
        return 0
    else
        log_error "同步到 VPS 失败"
        return 1
    fi
}

# ============================================
# 更新 VPS 索引
# ============================================
update_vps_index() {
    log "更新 VPS 索引..."
    
    # 生成索引 JSON
    local index_file="${BOTTLE_DIR}/loong64/index.json"
    
    echo '{' > "$index_file"
    echo '  "bottles": [' >> "$index_file"
    
    local first=true
    while IFS=',' read -r pkg sha256 filename datetime; do
        [[ -z "$pkg" ]] && continue
        
        if [[ "$first" == "true" ]]; then
            first=false
        else
            echo ',' >> "$index_file"
        fi
        
        cat >> "$index_file" << EOF
    {
      "name": "$pkg",
      "sha256": "$sha256",
      "filename": "$filename",
      "url": "https://homebrewloongarch64.site/bottles/loong64/$filename",
      "date": "$datetime"
    }
EOF
    done < "${BOTTLE_DIR}/manifest-${DATE}.csv"
    
    echo '' >> "$index_file"
    echo '  ],' >> "$index_file"
    echo "  \"updated\": \"$(date -Iseconds)\"" >> "$index_file"
    echo '}' >> "$index_file"
    
    # 同步索引到 VPS
    rsync -avz "$index_file" "${VPS_HOST}:${VPS_BOTTLE_DIR}/index.json"
    
    # 设置权限
    ssh "$VPS_HOST" "chown -R http:http /var/www/homebrewloongarch64.site/bottles && chmod -R 755 /var/www/homebrewloongarch64.site/bottles"
    
    log_success "VPS 索引已更新"
}

# ============================================
# 推送到 GitHub
# ============================================
push_to_github() {
    local pkg="$1"
    
    if [[ "$GITHUB_AVAILABLE" != "true" ]]; then
        log_warn "GitHub 不可用，跳过推送"
        return 1
    fi
    
    log "推送更新到 GitHub..."
    
    cd "$REPO_ROOT"
    
    # 检查是否有变更
    if git diff --quiet HEAD && git diff --cached --quiet HEAD; then
        log "没有需要推送的变更"
        return 0
    fi
    
    # 配置 git
    git config user.email "ai-builder@homebrew-loong64.local" || true
    git config user.name "AI Builder" || true
    
    # 添加 bottle 信息到 formula (如果有)
    local bottle_info=""
    if [[ -f "${BOTTLE_DIR}/manifest-${DATE}.csv" ]]; then
        bottle_info=$(grep "^${pkg}," "${BOTTLE_DIR}/manifest-${DATE}.csv" 2>/dev/null | tail -1)
    fi
    
    # 提交变更
    git add -A
    
    local commit_msg="build: ${pkg} bottle for loong64

- Built at: $(date -Iseconds)
- Status: ✓ Success"
    
    if [[ -n "$bottle_info" ]]; then
        local sha256
        sha256=$(echo "$bottle_info" | cut -d',' -f2)
        commit_msg="${commit_msg}
- SHA256: ${sha256}"
    fi
    
    if git commit -m "$commit_msg"; then
        if git push origin "$GITHUB_BRANCH"; then
            log_success "已推送到 GitHub"
            return 0
        else
            log_error "推送到 GitHub 失败"
            return 1
        fi
    else
        log "没有需要提交的变更"
        return 0
    fi
}

# ============================================
# 处理单个包 (完整闭环)
# ============================================
process_package() {
    local pkg="$1"
    
    log "========================================"
    log "处理包: $pkg"
    log "========================================"
    
    # Step 1: 构建
    if ! build_package "$pkg"; then
        log_error "$pkg 构建失败，停止后续步骤"
        return 1
    fi
    
    # Step 2: 构建 Bottle
    if ! build_bottle "$pkg"; then
        log_warn "$pkg bottle 构建失败，继续其他步骤"
    fi
    
    # Step 3: 同步到 VPS
    if ! sync_to_vps "$pkg"; then
        log_warn "$pkg VPS 同步失败"
    fi
    
    # Step 4: 推送到 GitHub
    if ! push_to_github "$pkg"; then
        log_warn "$pkg GitHub 推送失败"
    fi
    
    log_success "$pkg 处理完成"
    return 0
}

# ============================================
# 批量处理
# ============================================
process_batch() {
    local packages=("$@")
    
    log "========================================"
    log "批量处理 ${#packages[@]} 个包"
    log "========================================"
    
    # 初始化 manifest
    echo "package,sha256,filename,datetime" > "${BOTTLE_DIR}/manifest-${DATE}.csv"
    
    for pkg in "${packages[@]}"; do
        process_package "$pkg" || true
        echo ""
    done
    
    # 最终同步所有索引
    if [[ "$VPS_AVAILABLE" == "true" ]]; then
        update_vps_index
    fi
}

# ============================================
# 显示使用帮助
# ============================================
show_usage() {
    cat << EOF
AI Build Controller - 全自动化构建控制系统

用法: $0 [选项] [包名...]

选项:
    -h, --help          显示帮助
    -a, --all           构建所有 Formula
    -l, --list          列出所有可用的 Formula
    -b, --build-only    仅构建，不创建 bottle/不同步
    --no-vps            跳过 VPS 同步
    --no-github         跳过 GitHub 推送
    --dry-run           模拟运行，不执行实际操作

示例:
    $0 curl wget                    构建指定包
    $0 -a                           构建所有包
    $0 -l                           列出可用包
    $0 redis --no-vps               构建但不同步到 VPS

完整闭环流程:
    1. 从源码构建包
    2. 构建 bottle
    3. 同步到 VPS
    4. 推送到 GitHub
    5. 更新索引

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
        if brew list "$name" &>/dev/null; then
            echo "  ✓ $name (已安装)"
        else
            echo "  - $name"
        fi
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
    
    echo ""
    echo "新 Bottles: ${#NEW_BOTTLES[@]}"
    for bottle in "${NEW_BOTTLES[@]}"; do
        echo "  📦 $bottle"
    done
    
    log "日志目录: $LOG_DIR"
    log "Bottle 目录: $BOTTLE_DIR"
}

# ============================================
# 主函数
# ============================================
main() {
    local packages=()
    local build_all=false
    local build_only=false
    local dry_run=false
    
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
            -b|--build-only)
                build_only=true
                shift
                ;;
            --no-vps)
                VPS_AVAILABLE=false
                shift
                ;;
            --no-github)
                GITHUB_AVAILABLE=false
                shift
                ;;
            --dry-run)
                dry_run=true
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
    
    # 如果是 dry-run 模式
    if [[ "$dry_run" == "true" ]]; then
        log "【模拟模式】不会执行实际操作"
    fi
    
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
    
    # 执行批量处理
    process_batch "${packages[@]}"
    
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
