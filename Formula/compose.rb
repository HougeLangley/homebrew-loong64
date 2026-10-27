class Compose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://example.org/compose"
  version "5.6.1"
  url "http://127.0.0.1:8080/brew/bottles/compose--5.6.1.loongarch64.bottle.tar.gz"
  sha256 "dcb45e87651b76ec638d787906572975ffca9230058ddbc0b2a2298356f874d2"

  def install
    bin.install "compose"
  end

  test do
    system "#{bin}/compose"
  end
end
