class Gogogot < Formula
  desc "Lightweight self-hosted AI agent. Open-source OpenClaw alternative in Go."
  homepage "https://example.org/gogogot"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/gogogot--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "8529940d9fcacf00803f64ef5f94383187ca8adf20c1038cd7645737bcbb96ad"

  def install
    bin.install "gogogot"
  end

  test do
    system "#{bin}/gogogot"
  end
end
