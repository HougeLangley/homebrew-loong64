#!/bin/bash
# Homebrew Loong64 One-Click Install Script
# Usage: /bin/bash -c "$(curl -fsSL https://homebrewloongarch64.site/install.sh)"

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check architecture
check_arch() {
    info "Checking architecture..."
    ARCH=$(uname -m)
    if [[ "$ARCH" != "loongarch64" ]]; then
        error "Unsupported architecture: $ARCH"
        error "Homebrew Loong64 only supports loongarch64"
        exit 1
    fi
    success "Architecture: $ARCH"
}

# Check OS
check_os() {
    info "Checking OS..."
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    success "OS check passed"
}

# Check dependencies
check_deps() {
    info "Checking dependencies..."
    local deps=("curl" "git" "ruby")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            warn "Missing: $dep"
        fi
    done
    success "Dependencies OK"
}

# Install Homebrew
install_brew() {
    info "Installing Homebrew..."
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    
    if [[ -d "$HOMEBREW_PREFIX" ]]; then
        warn "Homebrew already installed"
        return 0
    fi
    
    sudo mkdir -p "$HOMEBREW_PREFIX"
    sudo chown -R "$(whoami):" "$HOMEBREW_PREFIX"
    git clone https://github.com/Homebrew/brew "$HOMEBREW_PREFIX/Homebrew"
    mkdir -p "$HOMEBREW_PREFIX/bin"
    ln -sf "$HOMEBREW_PREFIX/Homebrew/bin/brew" "$HOMEBREW_PREFIX/bin/brew"
    success "Homebrew installed"
}

# Configure environment
setup_env() {
    info "Configuring environment..."
    local shell_rc="$HOME/.bashrc"
    [[ "$SHELL" == *"zsh" ]] && shell_rc="$HOME/.zshrc"
    
    if ! grep -q "Homebrew Loong64" "$shell_rc" 2>/dev/null; then
        cat >> "$shell_rc" << 'EOF'

# Homebrew Loong64
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export HOMEBREW_DEVELOPER=1
EOF
        success "Environment configured in $shell_rc"
    fi
    
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
}

# Add tap
add_tap() {
    info "Adding loong64 tap..."
    brew tap loongarch/homebrew-loong64 https://github.com/HougeLangley/homebrew-loong64 2>/dev/null || true
    success "Tap added"
}

# Main install
main() {
    echo "========================================"
    echo "🍺 Homebrew Loong64 Installer"
    echo "========================================"
    
    check_arch
    check_os
    check_deps
    install_brew
    setup_env
    
    info "Loading environment..."
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
    
    add_tap
    
    echo ""
    success "Installation complete! 🎉"
    echo ""
    echo "Please run: source ~/.bashrc (or ~/.zshrc)"
    echo "Then try: brew install loongarch/homebrew-loong64/curl"
    echo ""
    echo "For bottles: https://homebrewloongarch64.site"
}

main "$@"
