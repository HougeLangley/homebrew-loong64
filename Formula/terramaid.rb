class Terramaid < Formula
  desc "Utility for generating Mermaid diagrams from Terraform configurations"
  homepage "https://example.org/terramaid"
  version "2.15.3"
  url "http://127.0.0.1:8080/brew/bottles/terramaid--2.15.3.loongarch64.bottle.tar.gz"
  sha256 "d63de01141bd6dd138c47b66ac340e81506fedd60f3f3c49f65feefbee2c27cc"

  def install
    bin.install "terramaid"
  end

  test do
    system "#{bin}/terramaid"
  end
end
