#!/bin/bash
# Bottle 构建脚本 - 为 LoongArch 64 构建二进制分发包
# 用法: ./scripts/build-bottles.sh [package-name|all]

set -e

# 配置
BREW_PREFIX="/home/brew-build/brew"
BOTTLE_DIR="/home/brewbuilder/bottles"
LOG_DIR="/home/brewbuilder/logs"
DATE=$(date +%Y%m%d)

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

# 初始化目录
init_dirs() {
    mkdir -p "$BOTTLE_DIR/loong64"
    mkdir -p "$LOG_DIR"
    log_info "初始化目录完成"
}

# 构建单个 bottle
build_bottle() {
    local formula="$1"
    local log_file="$LOG_DIR/${formula}-${DATE}.log"
    
    log_info "开始构建 $formula bottle..."
    
    # 检查 formula 是否存在
    if ! brew list "$formula" &>/dev/null; then
        log_warn "$formula 未安装，尝试安装..."
        if ! brew install "$formula" 2>&1 | tee "$log_file"; then
            log_error "$formula 安装失败"
            return 1
        fi
    fi
    
    # 获取版本信息
    local version
    version=$(brew list --versions "$formula" | awk '{print $2}')
    log_info "$formula 版本: $version"
    
    # 构建 bottle
    log_info "构建 $formula bottle..."
    if brew bottle --json --root-url="https://github.com/HougeLangley/homebrew-loong64/releases/download/${formula}-${version}" "$formula" 2>&1 | tee -a "$log_file"; then
        # 移动 bottle 到目标目录
        local bottle_file
        bottle_file=$(ls -t *.tar.gz 2>/dev/null | head -1)
        if [[ -n "$bottle_file" ]]; then
            mv "$bottle_file" "$BOTTLE_DIR/loong64/"
            log_info "Bottle 已保存: $BOTTLE_DIR/loong64/$bottle_file"
            
            # 生成 SHA256
            local sha256
            sha256=$(sha256sum "$BOTTLE_DIR/loong64/$bottle_file" | awk '{print $1}')
            log_info "SHA256: $sha256"
            
            # 记录到清单
            echo "${formula},${version},${sha256},${bottle_file}" >> "$BOTTLE_DIR/manifest-${DATE}.csv"
        fi
        
        # 清理临时文件
        rm -f *.json
        
        log_info "$formula bottle 构建完成!"
        return 0
    else
        log_error "$formula bottle 构建失败"
        return 1
    fi
}

# 批量构建所有已安装包
build_all_bottles() {
    log_info "开始批量构建所有已安装包..."
    
    local packages
    packages=$(brew list --formula)
    local total
    total=$(echo "$packages" | wc -l)
    local count=0
    local success=0
    local failed=0
    
    echo "package,version,sha256,filename" > "$BOTTLE_DIR/manifest-${DATE}.csv"
    
    for pkg in $packages; do
        count=$((count + 1))
        log_info "[$count/$total] 处理 $pkg..."
        
        if build_bottle "$pkg"; then
            success=$((success + 1))
        else
            failed=$((failed + 1))
        fi
        
        echo "---"
    done
    
    log_info "批量构建完成!"
    log_info "成功: $success, 失败: $failed, 总计: $total"
}

# 生成 bottle 索引
generate_index() {
    log_info "生成 bottle 索引..."
    
    local index_file="$BOTTLE_DIR/loong64/index.json"
    
    cat > "$index_file" << EOF
{
  "arch": "loong64",
  "date": "$DATE",
  "packages": [
EOF
    
    local first=true
    while IFS=',' read -r pkg version sha256 filename; do
        [[ "$pkg" == "package" ]] && continue
        
        if [[ "$first" == true ]]; then
            first=false
        else
            echo "," >> "$index_file"
        fi
        
        cat >> "$index_file" << EOF
    {
      "name": "$pkg",
      "version": "$version",
      "sha256": "$sha256",
      "url": "https://github.com/HougeLangley/homebrew-loong64/releases/download/${pkg}-${version}/${filename}"
    }
EOF
    done < <(tail -n +2 "$BOTTLE_DIR/manifest-${DATE}.csv")
    
    cat >> "$index_file" << EOF

  ]
}
EOF
    
    log_info "索引已生成: $index_file"
}

# 主函数
main() {
    log_info "=== Homebrew Loong64 Bottle 构建脚本 ==="
    log_info "日期: $DATE"
    log_info "输出目录: $BOTTLE_DIR"
    
    # 设置环境
    export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$HOME/.cargo/bin:$PATH"
    export HOMEBREW_DEVELOPER=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_FROM_API=1
    source "$HOME/.cargo/env" 2>/dev/null || true
    
    init_dirs
    
    if [[ $# -eq 0 ]] || [[ "$1" == "all" ]]; then
        build_all_bottles
        generate_index
    else
        build_bottle "$1"
    fi
    
    log_info "完成!"
}

main "$@"
