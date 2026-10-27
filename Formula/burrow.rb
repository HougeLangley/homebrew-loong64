class Burrow < Formula
  desc "Burrow is a globally distributed HTTP proxy via AWS Lambda"
  homepage "https://example.org/burrow"
  version "0.0.7"
  url "http://127.0.0.1:8080/brew/bottles/burrow--0.0.7.loongarch64.bottle.tar.gz"
  sha256 "517840b9400c63fd5f49d189ecd082f5ef2d7585a6e0d3f2570d5455782c5d9a"

  def install
    bin.install "burrow"
  end

  test do
    system "#{bin}/burrow"
  end
end
