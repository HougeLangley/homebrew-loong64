#!/bin/bash
set -e

BOTTLE_DIR="/home/brewbuilder/bottles"
LOG_DIR="/home/brewbuilder/logs"
DATE=$(date +%Y%m%d)
mkdir -p "$BOTTLE_DIR/loong64" "$LOG_DIR"

log() {
    echo "[$(date '+%H:%M:%S')] $1"
}

build_bottle() {
    local pkg="$1"
    local log_file="$LOG_DIR/${pkg}-${DATE}.log"
    
    log "处理 $pkg..."
    
    if brew list "$pkg" &>/dev/null; then
        log "卸载现有 $pkg..."
        brew uninstall "$pkg" 2>/dev/null || true
    fi
    
    log "使用 --build-bottle 安装 $pkg..."
    if brew install --build-bottle "$pkg" 2>&1 | tee "$log_file"; then
        log "$pkg 安装成功"
        
        log "构建 bottle..."
        if brew bottle --json --root-url="https://github.com/HougeLangley/homebrew-loong64/releases/download/bottles" "$pkg" 2>&1 | tee -a "$log_file"; then
            for f in *.tar.gz; do
                if [[ -f "$f" ]]; then
                    mv "$f" "$BOTTLE_DIR/loong64/"
                    log "Bottle 保存: $f"
                    local sha256
                    sha256=$(sha256sum "$BOTTLE_DIR/loong64/$f" | awk '{print $1}')
                    echo "${pkg},${sha256},${f}" >> "$BOTTLE_DIR/manifest-${DATE}.csv"
                fi
            done
            rm -f *.json
            log "$pkg bottle 构建完成!"
            return 0
        fi
    fi
    return 1
}

batch_build() {
    local packages=("$@")
    echo "package,sha256,filename" > "$BOTTLE_DIR/manifest-${DATE}.csv"
    
    for pkg in "${packages[@]}"; do
        build_bottle "$pkg" || true
        echo "---"
    done
}

main() {
    log "=== Bottle 构建系统 ==="
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_INSTALL_FROM_API=1
    
    if [[ $# -eq 0 ]]; then
        log "用法: $0 <package1> [package2] ..."
        exit 1
    fi
    
    batch_build "$@"
}

main "$@"
