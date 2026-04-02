#!/bin/bash
# VPS Sync Service - 后台同步服务
# 功能: 监控本地 bottle 目录并自动同步到 VPS
# 用法: ./vps-sync-service.sh [start|stop|status|sync-now]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIDFILE="/tmp/vps-sync-service.pid"
LOGFILE="/tmp/vps-sync-service.log"
BOTTLE_DIR="${HOME}/brew-bottles/loong64"
VPS_HOST="root@47.242.26.188"
VPS_DIR="/var/www/homebrewloongarch64.site/bottles/loong64"
CHECK_INTERVAL=60

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

start_service() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        log "服务已在运行 (PID: $(cat "$PIDFILE"))"
        return 0
    fi
    
    log "启动 VPS 同步服务..."
    
    (
        while true; do
            if [ -d "$BOTTLE_DIR" ]; then
                # 检查是否有新文件
                find "$BOTTLE_DIR" -name "*.tar.gz" -newer "$LOGFILE" 2>/dev/null | while read -r file; do
                    log "检测到新 bottle: $(basename "$file")"
                done
                
                # 执行同步
                sync_bottles
            fi
            
            sleep "$CHECK_INTERVAL"
        done
    ) &
    
    echo $! > "$PIDFILE"
    log "服务已启动 (PID: $(cat "$PIDFILE"))"
}

stop_service() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            log "停止服务 (PID: $PID)..."
            kill "$PID"
            rm -f "$PIDFILE"
            log "服务已停止"
        else
            log "服务未运行"
            rm -f "$PIDFILE"
        fi
    else
        log "服务未运行"
    fi
}

check_status() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        log "服务运行中 (PID: $(cat "$PIDFILE"))"
        log "日志文件: $LOGFILE"
        log "监控目录: $BOTTLE_DIR"
        return 0
    else
        log "服务未运行"
        return 1
    fi
}

sync_bottles() {
    log "开始同步 bottles 到 VPS..."
    
    if [ ! -d "$BOTTLE_DIR" ]; then
        log "错误: Bottle 目录不存在"
        return 1
    fi
    
    # 检查 VPS 连接
    if ! ssh -q -o ConnectTimeout=5 "$VPS_HOST" "echo OK" &>/dev/null; then
        log "错误: 无法连接到 VPS"
        return 1
    fi
    
    # 同步 bottles
    if rsync -avz --progress "$BOTTLE_DIR/" "$VPS_HOST:$VPS_DIR/" 2>&1 | tee -a "$LOGFILE"; then
        log "Bottles 同步成功"
        
        # 更新索引
        update_index
        
        # 设置权限
        ssh "$VPS_HOST" "chown -R http:http /var/www/homebrewloongarch64.site/bottles && chmod -R 755 /var/www/homebrewloongarch64.site/bottles"
        
        log "同步完成: https://homebrewloongarch64.site/bottles/"
        return 0
    else
        log "同步失败"
        return 1
    fi
}

update_index() {
    log "更新索引..."
    
    local index_file="$BOTTLE_DIR/index.json"
    
    echo '{' > "$index_file"
    echo '  "bottles": [' >> "$index_file"
    
    local first=true
    for f in "$BOTTLE_DIR"/*.tar.gz; do
        [ -f "$f" ] || continue
        
        local name sha256 filename
        filename=$(basename "$f")
        name=$(echo "$filename" | sed 's/-[0-9].*//')
        sha256=$(sha256sum "$f" | awk '{print $1}')
        
        if [ "$first" = true ]; then
            first=false
        else
            echo ',' >> "$index_file"
        fi
        
        cat >> "$index_file" << EOF
    {
      "name": "$name",
      "sha256": "$sha256",
      "filename": "$filename",
      "url": "https://homebrewloongarch64.site/bottles/loong64/$filename",
      "date": "$(date -Iseconds)"
    }
EOF
    done
    
    echo '' >> "$index_file"
    echo '  ],' >> "$index_file"
    echo "  \"updated\": \"$(date -Iseconds)\"" >> "$index_file"
    echo '}' >> "$index_file"
    
    # 同步索引到 VPS
    rsync -avz "$index_file" "$VPS_HOST:$VPS_DIR/index.json"
    
    log "索引已更新"
}

case "${1:-}" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    restart)
        stop_service
        sleep 1
        start_service
        ;;
    status)
        check_status
        ;;
    sync-now)
        sync_bottles
        ;;
    *)
        echo "VPS Sync Service"
        echo ""
        echo "用法: $0 [start|stop|restart|status|sync-now]"
        echo ""
        echo "命令:"
        echo "  start      启动后台同步服务"
        echo "  stop       停止后台同步服务"
        echo "  restart    重启服务"
        echo "  status     查看服务状态"
        echo "  sync-now   立即执行一次同步"
        echo ""
        echo "配置:"
        echo "  Bottle 目录: $BOTTLE_DIR"
        echo "  VPS 主机: $VPS_HOST"
        echo "  检查间隔: ${CHECK_INTERVAL}秒"
        exit 1
        ;;
esac
