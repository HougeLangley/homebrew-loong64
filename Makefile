.PHONY: help install test audit clean lint

help:
	@echo "Homebrew Loong64 Tap - Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  install    Install/Update the tap locally"
	@echo "  test       Run tests for all formulas"
	@echo "  audit      Audit formulas for issues"
	@echo "  lint       Run style checks"
	@echo "  build      Batch build all formulas"
	@echo "  clean      Clean build artifacts"
	@echo "  info       Show tap information"
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
