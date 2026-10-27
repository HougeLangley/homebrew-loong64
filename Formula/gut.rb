class Gut < Formula
  desc "A beginner friendly CLI for git"
  homepage "https://example.org/gut"
  version "0.3.3"
  url "http://127.0.0.1:8080/brew/bottles/gut--0.3.3.loongarch64.bottle.tar.gz"
  sha256 "7d9592f565cf9406e65b059fe4c3830d0c4288fc9209da34870171ab6b5af9cf"

  def install
    bin.install "gut"
  end

  test do
    system "#{bin}/gut"
  end
end
