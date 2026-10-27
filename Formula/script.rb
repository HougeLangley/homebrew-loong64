class Script < Formula
  desc "Making it easy to write shell-like scripts in Go"
  homepage "https://example.org/script"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/script--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "f394156a050c346e21316cecc61e9a92731f5625eec1a590f3b36263546ba99a"

  def install
    bin.install "script"
  end

  test do
    system "#{bin}/script"
  end
end
