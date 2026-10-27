class Hertz < Formula
  desc "Go HTTP framework with high-performance and strong-extensibility for building micro-servic"
  homepage "https://example.org/hertz"
  version "0.10.6"
  url "http://127.0.0.1:8080/brew/bottles/hertz--0.10.6.loongarch64.bottle.tar.gz"
  sha256 "a805491dbb04492ef0c74ad26d7f60d1bc7b7b9b1e4f9c14c4c9d22e9e19d79d"

  def install
    bin.install "hertz"
  end

  test do
    system "#{bin}/hertz"
  end
end
