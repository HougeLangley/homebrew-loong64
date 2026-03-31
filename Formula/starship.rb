class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://starship.rs"
  url "https://github.com/starship/starship/archive/refs/tags/v1.22.1.tar.gz"
  sha256 "54c468a7deb9a87a46a99066406e5ad9c813b902889c0d9c8d8ba14db40df2d4"
  license "ISC"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    
    bin.install "target/release/starship"
    
    # 安装 shell completions
    bash_completion.install "docs/public/install/starship.bash" => "starship"
    zsh_completion.install "docs/public/install/_starship"
    fish_completion.install "docs/public/install/starship.fish"
    
    # 安装 man page
    man1.install "docs/public/man/man1/starship.1"
  end

  def caveats
    <<~EOS
      To initialize starship, add the following to your shell configuration file:
      
      For bash:
        eval "$(starship init bash)"
      
      For zsh:
        eval "$(starship init zsh)"
      
      For fish:
        starship init fish | source
    EOS
  end

  test do
    system "#{bin}/starship", "--version"
  end
end
