#!/bin/bash
# Bottle 同步脚本 - 将本地 bottles 上传到 VPS
# 用法: ./scripts/sync-bottles-to-vps.sh

set -e

# 配置
VPS_HOST="root@47.242.26.188"
VPS_BOTTLE_DIR="/var/www/bottles/loong64"
LOCAL_BOTTLE_DIR="/home/brewbuilder/bottles/loong64"
LOCAL_INDEX="/home/brewbuilder/bottles/loong64/index.json"

echo "=== Homebrew Loong64 Bottle 同步脚本 ==="
echo "VPS: $VPS_HOST"
echo "本地目录: $LOCAL_BOTTLE_DIR"
echo "远程目录: $VPS_BOTTLE_DIR"
echo ""

# 检查本地目录是否存在
if [[ ! -d "$LOCAL_BOTTLE_DIR" ]]; then
    echo "错误: 本地 bottle 目录不存在: $LOCAL_BOTTLE_DIR"
    exit 1
fi

# 同步 bottles
echo "[1/3] 同步 bottles 到 VPS..."
rsync -avz --progress "$LOCAL_BOTTLE_DIR/" "$VPS_HOST:$VPS_BOTTLE_DIR/"

# 同步索引文件
if [[ -f "$LOCAL_INDEX" ]]; then
    echo ""
    echo "[2/3] 同步索引文件..."
    rsync -avz "$LOCAL_INDEX" "$VPS_HOST:$VPS_BOTTLE_DIR/index.json"
fi

# 设置权限
echo ""
echo "[3/3] 设置远程权限..."
ssh "$VPS_HOST" "chown -R http:http /var/www/bottles && chmod -R 755 /var/www/bottles"

echo ""
echo "=== 同步完成 ==="
echo "访问: https://homebrewloongarch64.site/bottles/"
