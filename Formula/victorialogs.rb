class Victorialogs < Formula
  desc "Open source user-friendly database for logs from VictoriaMetrics"
  homepage "https://example.org/victorialogs"
  version "1.53.0"
  url "http://127.0.0.1:8080/brew/bottles/victorialogs--1.53.0.loongarch64.bottle.tar.gz"
  sha256 "c9617d8cd28313837aad9f81a1f37813e2588c03883f59349caa34e391d0b498"

  def install
    bin.install "victorialogs"
  end

  test do
    system "#{bin}/victorialogs"
  end
end
