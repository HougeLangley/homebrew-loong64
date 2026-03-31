#!/bin/bash
# batch-build.sh: Batch build Homebrew formulas for LoongArch architecture

set -e

TAP_PATH="/home/brew-build/brew/Library/Taps/loongarch/homebrew-local"
FORMULA_DIR="$TAP_PATH/Formula"
LOG_FILE="/tmp/batch-build-$(date +%Y%m%d-%H%M%S).log"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SUCCESS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0

log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

build_formula() {
    local formula=$1
    local formula_path="$FORMULA_DIR/$formula"
    
    log "${YELLOW}Building $formula...${NC}"
    
    if brew list "$(basename "$formula" .rb)" &>/dev/null; then
        log "${YELLOW}  → Already installed, skipping${NC}"
        ((SKIP_COUNT++))
        return 0
    fi
    
    if brew install --build-from-source "$formula_path" 2>&1 | tee -a "$LOG_FILE"; then
        log "${GREEN}  ✓ $formula built successfully${NC}"
        ((SUCCESS_COUNT++))
        return 0
    else
        log "${RED}  ✗ $formula failed${NC}"
        ((FAIL_COUNT++))
        return 1
    fi
}

show_usage() {
    cat << EOF
Usage: $0 [OPTIONS] [FORMULA...]

Batch build Homebrew formulas for LoongArch.

OPTIONS:
    -h, --help      Show this help message
    -a, --all       Build all formulas in Formula/
    -l, --list      List all available formulas
    -c, --clean     Clean up before building

EXAMPLES:
    $0 -a                    Build all formulas
    $0 curl wget vim         Build specific formulas
    $0 -l                    List available formulas
    $0 -c -a                 Clean and build all

EOF
}

list_formulas() {
    log "Available formulas:"
    for formula in "$FORMULA_DIR"/*.rb; do
        local name=$(basename "$formula" .rb)
        if brew list "$name" &>/dev/null; then
            log "  ✓ $name (installed)"
        else
            log "  - $name"
        fi
    done
}

clean_up() {
    log "${YELLOW}Cleaning up...${NC}"
    brew cleanup -s 2>/dev/null || true
    rm -rf "$HOME/.cache/Homebrew/downloads"/*
}

show_summary() {
    log ""
    log "========================================"
    log "Build Summary"
    log "========================================"
    log "Success: ${GREEN}$SUCCESS_COUNT${NC}"
    log "Failed:  ${RED}$FAIL_COUNT${NC}"
    log "Skipped: ${YELLOW}$SKIP_COUNT${NC}"
    log "Total:   $((SUCCESS_COUNT + FAIL_COUNT + SKIP_COUNT))"
    log ""
    log "Log file: $LOG_FILE"
    log "========================================"
}

main() {
    local build_all=false
    local formulas_to_build=()
    
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
            -c|--clean)
                clean_up
                shift
                ;;
            -*)
                log "${RED}Unknown option: $1${NC}"
                show_usage
                exit 1
                ;;
            *)
                formulas_to_build+=("$1.rb")
                shift
                ;;
        esac
    done
    
    log "========================================"
    log "Homebrew Loong64 Batch Build"
    log "Started: $(date)"
    log "========================================"
    log ""
    
    if $build_all; then
        for formula in "$FORMULA_DIR"/*.rb; do
            build_formula "$(basename "$formula")" || true
        done
    elif [[ ${#formulas_to_build[@]} -gt 0 ]]; then
        for formula in "${formulas_to_build[@]}"; do
            if [[ -f "$FORMULA_DIR/$formula" ]]; then
                build_formula "$formula" || true
            else
                log "${RED}Formula not found: $formula${NC}"
            fi
        done
    else
        log "${YELLOW}No formulas specified. Use -a for all, or -h for help.${NC}"
        show_usage
        exit 1
    fi
    
    show_summary
}

trap 'show_summary' EXIT

main "$@"
