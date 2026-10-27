class Mercadona-cli < Formula
  desc "Unofficial, agent-friendly Mercadona shopping CLI (Go) — search products, read prices, bui"
  homepage "https://example.org/mercadona-cli"
  version "0.1.9"
  url "http://127.0.0.1:8080/brew/bottles/mercadona-cli--0.1.9.loongarch64.bottle.tar.gz"
  sha256 "01c23b2ba860cf7b8d9f2f17bcda523024e1ad49c531e5798b804e14a4391f43"

  def install
    bin.install "mercadona-cli"
  end

  test do
    system "#{bin}/mercadona-cli"
  end
end
