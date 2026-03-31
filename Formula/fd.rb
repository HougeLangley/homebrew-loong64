class Fd < Formula
  desc "Simple, fast and user-friendly alternative to find"
  homepage "https://github.com/sharkdp/fd"
  url "https://github.com/sharkdp/fd/archive/refs/tags/v10.2.0.tar.gz"
  sha256 "199e87ec87979310d4e0c053c13d30ce7b761a66166790b8503ee9a1bd016a5e"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    
    bin.install "target/release/fd"
    man1.install "doc/fd.1"
    
    bash_completion.install "contrib/completion/fd.bash" => "fd"
    fish_completion.install "contrib/completion/fd.fish"
    zsh_completion.install "contrib/completion/_fd"
  end

  test do
    system "#{bin}/fd", "--version"
  end
end
