class Fgit < Formula
  desc "加速100～3000倍的github.com"
  homepage "https://example.org/fgit"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/fgit--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "8810129b2b951988a3c65858157a4aa46ffa42a3bed2bd5917cd009638d3ac69"

  def install
    bin.install "fgit"
  end

  test do
    system "#{bin}/fgit"
  end
end
