class Zoxide < Formula
  desc "Fast cd command that learns your habits"
  homepage "https://github.com/ajeetdsouza/zoxide"
  url "https://github.com/ajeetdsouza/zoxide/archive/refs/tags/v0.9.7.tar.gz"
  sha256 "d93ab17a01de68529f150eb2ab3964b74c875284de78f79f9b0b69fa4d136523"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    
    bin.install "target/release/zoxide"
    
    # 安装 shell completions
    bash_completion.install "contrib/completions/zoxide.bash" => "zoxide"
    zsh_completion.install "contrib/completions/_zoxide"
    fish_completion.install "contrib/completions/zoxide.fish"
    
    # 安装 man pages
    man1.install Dir["man/man1/*.1"]
  end

  def caveats
    <<~EOS
      To initialize zoxide, add the following to your shell configuration file:
      
      For bash:
        eval "$(zoxide init bash)"
      
      For zsh:
        eval "$(zoxide init zsh)"
      
      For fish:
        zoxide init fish | source
    EOS
  end

  test do
    system "#{bin}/zoxide", "--version"
  end
end
