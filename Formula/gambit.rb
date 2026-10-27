class Gambit < Formula
  desc "Play chess in your terminal"
  homepage "https://example.org/gambit"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/gambit--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "6429d3e31f1e30468c0fc2ff3e076e98f3ea1ba87b8dd52cf6248201fc294190"

  def install
    bin.install "gambit"
  end

  test do
    system "#{bin}/gambit"
  end
end
