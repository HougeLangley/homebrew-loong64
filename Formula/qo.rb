class Qo < Formula
  desc "Interactive minimalist TUI to query JSON, CSV, and TSV using SQL"
  homepage "https://example.org/qo"
  version "0.5.1"
  url "http://127.0.0.1:8080/brew/bottles/qo--0.5.1.loongarch64.bottle.tar.gz"
  sha256 "a3b2296d333af1f2a1fdf598da8f8cc6ecde889fc285cb07270fbb0125eeb80f"

  def install
    bin.install "qo"
  end

  test do
    system "#{bin}/qo"
  end
end
