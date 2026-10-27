class Ggc < Formula
  desc "A modern Git CLI tool with both traditional command-line and interactive incremental-searc"
  homepage "https://example.org/ggc"
  version "8.7.6"
  url "http://127.0.0.1:8080/brew/bottles/ggc--8.7.6.loongarch64.bottle.tar.gz"
  sha256 "9bae0142599938e766e3d5362d931738c55450b6cf073e73a0e5ddf38f5cca76"

  def install
    bin.install "ggc"
  end

  test do
    system "#{bin}/ggc"
  end
end
