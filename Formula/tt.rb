class Tt < Formula
  desc "A terminal based typing test."
  homepage "https://example.org/tt"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/tt--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "8a4bfb12000cf6d5b1a43b0198545f8adcc971aff0f655aafd07f1074a87dd40"

  def install
    bin.install "tt"
  end

  test do
    system "#{bin}/tt"
  end
end
