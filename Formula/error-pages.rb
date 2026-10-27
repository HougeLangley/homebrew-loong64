class Error-pages < Formula
  desc "🪂 Tiny, zero-dep HTTP server & Docker image serving pretty, themeable, localized HTTP erro"
  homepage "https://example.org/error-pages"
  version "4.2.7"
  url "http://127.0.0.1:8080/brew/bottles/error-pages--4.2.7.loongarch64.bottle.tar.gz"
  sha256 "109653b507baf3c23c8fd700efb15aae1c77015c7616c1769a7b744040ee3b00"

  def install
    bin.install "error-pages"
  end

  test do
    system "#{bin}/error-pages"
  end
end
