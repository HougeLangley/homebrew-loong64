.PHONY: help install test audit clean lint build bottle sync phase4 ai-build

help:
	@echo "Homebrew Loong64 Tap - Makefile"
	@echo ""
	@echo "基础命令:"
	@echo "  install      安装/更新本地 tap"
	@echo "  test         测试所有 formulas"
	@echo "  audit        审计 formulas"
	@echo "  lint         运行风格检查"
	@echo "  build        批量构建所有 formulas"
	@echo "  clean        清理构建产物"
	@echo "  info         显示 tap 信息"
	@echo ""
	@echo "AI 构建控制器 (完整闭环):"
	@echo "  ai-build     使用 AI 控制器构建 (构建→Bottle→同步→推送)"
	@echo "  ai-build-all 构建所有包"
	@echo "  bottle PKG   为指定包构建 bottle"
	@echo "  sync         同步 bottles 到 VPS"
	@echo ""
	@echo "Phase 4 扩展构建:"
	@echo "  phase4-p0    构建关键包"
	@echo "  phase4-p1    构建关键+重要包"
	@echo "  phase4-all   构建所有候选包"
	@echo ""

install:
	@echo "Installing loongarch/homebrew-loong64 tap..."
	@if [ -d "$(shell brew --repo)/Library/Taps/loongarch/homebrew-loong64" ]; then \
		echo "Tap already exists, updating..."; \
		cd "$(shell brew --repo)/Library/Taps/loongarch/homebrew-loong64" && git pull; \
	else \
		brew tap loongarch/homebrew-loong64 "$(PWD)"; \
	fi
	@echo "Done!"

test:
	@echo "Testing formulas..."
	@for formula in Formula/*.rb; do \
		echo "Testing $$formula..."; \
		brew test "$$formula" 2>/dev/null || echo "Failed: $$formula"; \
	done

audit:
	@echo "Auditing formulas..."
	@for formula in Formula/*.rb; do \
		echo "Auditing $$formula..."; \
		brew audit --strict "$$formula" 2>/dev/null || echo "Issues found in: $$formula"; \
	done

lint:
	@echo "Running style checks..."
	@ruby -c Formula/*.rb

build:
	@echo "Batch building all formulas..."
	@./scripts/batch-build.sh -a

clean:
	@echo "Cleaning up..."
	@brew cleanup -s 2>/dev/null || true
	@rm -rf /tmp/batch-build-*.log

info:
	@echo "Tap Information:"
	@echo "  Location: $(PWD)"
	@echo "  Formulas: $(shell ls Formula/*.rb 2>/dev/null | wc -l)"
	@echo "  Brew prefix: $(shell brew --prefix 2>/dev/null || echo 'Not installed')"
	@echo ""
	@echo "Available formulas:"
	@ls Formula/*.rb 2>/dev/null | xargs -n1 basename -s .rb | xargs -n5 echo "  "

# AI 构建控制器
ai-build:
	@echo "启动 AI 构建控制器..."
	@./scripts/ai-build-controller.sh $(PKG)

ai-build-all:
	@echo "使用 AI 控制器构建所有包..."
	@./scripts/ai-build-controller.sh --all

bottle:
	@if [ -z "$(PKG)" ]; then \
		echo "用法: make bottle PKG=package_name"; \
		exit 1; \
	fi
	@echo "构建 $(PKG) 的 bottle..."
	@./scripts/ai-build-controller.sh $(PKG)

sync:
	@echo "同步 bottles 到 VPS..."
	@./scripts/vps-sync-service.sh sync-now

# Phase 4 扩展构建
phase4-p0:
	@echo "Phase 4: 构建关键包 (P0)..."
	@./scripts/phase4-builder.sh -p0

phase4-p1:
	@echo "Phase 4: 构建关键+重要包 (P0+P1)..."
	@./scripts/phase4-builder.sh -p1

phase4-all:
	@echo "Phase 4: 构建所有候选包..."
	@./scripts/phase4-builder.sh -p2

# 容器化构建
container-build:
	@echo "使用容器化流程构建..."
	@echo "1. 确保在编译机 (192.168.50.244) 上执行"
	@echo "2. 使用: ./scripts/batch_build.sh <package>"

# 查看构建状态
build-status:
	@echo "查看构建状态..."
	@ssh houge@192.168.50.244 'ls -la /var/lib/machines/ 2>/dev/null | grep homebrew-build'

# 清理编译机构建容器
clean-builders:
	@echo "清理编译机上的构建容器..."
	@ssh houge@192.168.50.244 'sudo rm -rf /var/lib/machines/homebrew-build-* 2>/dev/null; echo "清理完成"'
