class Terramaid < Formula
  desc "Utility for generating Mermaid diagrams from Terraform configurations"
  homepage "https://example.org/terramaid"
  version "2.15.3"
  url "http://127.0.0.1:8080/brew/bottles/terramaid--2.15.3.loongarch64.bottle.tar.gz"
  sha256 "242308eece07c4e8cd7a71c42cb5f218b03cbe92f3af8f7ea2715f535166a5b5"

  def install
    bin.install "terramaid"
  end

  test do
    system "#{bin}/terramaid"
  end
end
