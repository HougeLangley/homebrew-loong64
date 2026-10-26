class Btop < Formula
  desc "Resource monitor with a beautiful terminal UI"
  homepage "https://example.org/btop"
  version "1.4.8"
  url "http://127.0.0.1:8080/brew/bottles/btop--1.4.8.loongarch64.bottle.tar.gz"
  sha256 "64233a2aa8f85d43270afb982c10e6f805d602d3720b123b3401487b48b9f608"

  def install
    bin.install "btop"
  end

  test do
    system "#{bin}/btop"
  end
end
