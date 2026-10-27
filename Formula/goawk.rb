class Goawk < Formula
  desc "POSIX-compliant AWK interpreter written in Go"
  homepage "https://example.org/goawk"
  version "1.32.0"
  url "http://127.0.0.1:8080/brew/bottles/goawk--1.32.0.loongarch64.bottle.tar.gz"
  sha256 "87c520574fc08d7bf41a04c286b871e3892c56e4c3cef05f168fa89b559a6976"

  def install
    bin.install "goawk"
  end

  test do
    system "#{bin}/goawk"
  end
end
