#!/bin/bash
# 清理编译机 #2 的僵尸进程并恢复构建

# 步骤 1: 杀死僵尸进程的父进程
# PID 1970 是 bash 僵尸进程的父进程
kill -9 1970 2>/dev/null || true

# 步骤 2: 清理其他可能卡住的构建进程
pkill -9 -f "brew install" 2>/dev/null || true
pkill -9 -f "brew bottle" 2>/dev/null || true

# 步骤 3: 等待僵尸进程被 init 回收
sleep 2

# 步骤 4: 检查是否还有僵尸进程
echo "剩余僵尸进程:"
ps -A -o stat,ppid,pid,cmd | grep -e '^[Zz]' | wc -l

# 步骤 5: 重启构建
cd ~/dual-build
source /home/brew-build/setup-homebrew-env.sh

# 继续未完成的构建
for pkg in $(ls Formula/*.rb | tail -27 | xargs -n1 basename -s .rb); do
  # 检查是否已经成功构建
  if ls ~/brew-bottles/loong64/${pkg}*.tar.gz 1>/dev/null 2>&1; then
    echo "[跳过] $pkg 已存在"
    continue
  fi
  
  echo "[构建] $pkg"
  brew uninstall "$pkg" 2>/dev/null || true
  
  if brew install --build-bottle "Formula/${pkg}.rb" 2>&1 | tee ~/brew-logs/${pkg}-build.log; then
    echo "[✓ 成功] $pkg"
    cd ~/brew-bottles
    brew bottle --json --root-url=https://homebrewloongarch64.site/bottles/loong64 "$pkg" 2>&1 | tee -a ~/brew-logs/${pkg}-build.log
    mv *.tar.gz loong64/ 2>/dev/null || true
    rm -f *.json
    brew uninstall "$pkg" 2>/dev/null || true
  else
    echo "[✗ 失败] $pkg"
  fi
  cd ~/dual-build
done

echo "构建完成" > ~/dual-build/build-complete-2.log
echo "所有包处理完成"
