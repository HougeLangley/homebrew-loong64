class Ripgrep < Formula
  desc "Search tool like grep and The Silver Searcher"
  homepage "https://github.com/BurntSushi/ripgrep"
  url "https://github.com/BurntSushi/ripgrep/archive/refs/tags/15.1.0.tar.gz"
  sha256 "a88d06f2ef71f199a5e25daa2f874b9260341c65b9d18ee1d18c6fbb3ed0757c"
  license "Unlicense"

  bottle do
    root_url "https://homebrewloongarch64.site/bottles"
    sha256 cellar: :any, loongarch64_linux: "0cea745f75b7cacb6c9296d442f158bff0fdfa1aa2333295ea06cecedc38188b"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--features", "pcre2"
    
    bin.install "target/release/rg"
    
    bash_completion.install "complete/rg.bash" => "rg"
    fish_completion.install "complete/rg.fish"
    zsh_completion.install "complete/_rg"
    man1.install "doc/rg.1"
    doc.install "FAQ.md", "GUIDE.md"
  end

  test do
    system "#{bin}/rg", "--version"
  end
end
