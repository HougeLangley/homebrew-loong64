class Gdu < Formula
  desc "Fast disk usage analyzer"
  homepage "https://example.org/gdu"
  version "5.38.0"
  url "http://127.0.0.1:8080/brew/bottles/gdu--5.38.0.loongarch64.bottle.tar.gz"
  sha256 "200206bc3e1a350b1e95bc985f0a4aad575fd8fc08def9422ca3982660abed8a"

  def install
    bin.install "gdu"
  end

  test do
    system "#{bin}/gdu"
  end
end
