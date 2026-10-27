class Go-recipes < Formula
  desc "🦩 Tools for Go projects"
  homepage "https://example.org/go-recipes"
  version "2025-12"
  url "http://127.0.0.1:8080/brew/bottles/go-recipes--2025-12.loongarch64.bottle.tar.gz"
  sha256 "87b12c891b500eb6dc5557320394f14c512f65f8eacad3a897ec9f70e355bcec"

  def install
    bin.install "go-recipes"
  end

  test do
    system "#{bin}/go-recipes"
  end
end
