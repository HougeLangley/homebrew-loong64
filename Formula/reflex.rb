class Reflex < Formula
  desc "Run a command when files change"
  homepage "https://example.org/reflex"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/reflex--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "605f3f71bdaa9781675ac17c373141e5a72d36f69ca02a13d3fde92e541155d9"

  def install
    bin.install "reflex"
  end

  test do
    system "#{bin}/reflex"
  end
end
