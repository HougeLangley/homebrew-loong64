class Picoclaw < Formula
  desc "Ultra-efficient personal AI assistant in Go"
  homepage "https://example.org/picoclaw"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/picoclaw--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "1743a337f4fd7fa4e132f96e70632863f39a90aa22540453093a113176dd32ac"

  def install
    bin.install "picoclaw"
  end

  test do
    system "#{bin}/picoclaw"
  end
end
