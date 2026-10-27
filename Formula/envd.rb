class Envd < Formula
  desc "🏕️ Reproducible development environment for humans and agents"
  homepage "https://example.org/envd"
  version "1.3.6"
  url "http://127.0.0.1:8080/brew/bottles/envd--1.3.6.loongarch64.bottle.tar.gz"
  sha256 "a488e68a70bb0e1180209b45dfb7eb481eae5825c97c09eac5bdb552adbf8952"

  def install
    bin.install "envd"
  end

  test do
    system "#{bin}/envd"
  end
end
