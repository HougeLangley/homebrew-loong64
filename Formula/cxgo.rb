class Cxgo < Formula
  desc "Transpiling C to Go"
  homepage "https://example.org/cxgo"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/cxgo--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "c4e8b7851789c9b2466733fec347e8bd55cadff3c1e2a29292c2d2f7716c51db"

  def install
    bin.install "cxgo"
  end

  test do
    system "#{bin}/cxgo"
  end
end
