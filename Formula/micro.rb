class Micro < Formula
  desc "Modern and intuitive terminal-based text editor"
  homepage "https://micro-editor.github.io"
  url "https://github.com/zyedidia/micro/archive/refs/tags/v2.0.15.tar.gz"
  sha256 "6d463a576c1f47b15b9773d1781544e8416fb7c41e5c34c63ec753a0a5b9d752"
  license "MIT"

  depends_on "go" => :build

  def install
    system "make", "build"
    bin.install "micro"
    
    man1.install "assets/packaging/micro.1"
    (share/"micro").install "runtime"
  end

  test do
    system "#{bin}/micro", "--version"
  end
end
