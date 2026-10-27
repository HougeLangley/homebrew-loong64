class Bed < Formula
  desc "Binary editor written in Go"
  homepage "https://example.org/bed"
  version "0.2.9"
  url "http://127.0.0.1:8080/brew/bottles/bed--0.2.9.loongarch64.bottle.tar.gz"
  sha256 "fafd9a519d5e56a9af62605fd340141c76f2435c73bceaabfb01346dd9160cb0"

  def install
    bin.install "bed"
  end

  test do
    system "#{bin}/bed"
  end
end
