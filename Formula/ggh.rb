class Ggh < Formula
  desc "Recall your SSH sessions"
  homepage "https://example.org/ggh"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/ggh--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "4e8aa19cf3b34862a6a69c4f6c759d2cfcb9227dac3a1b6ae91de04df966d05b"

  def install
    bin.install "ggh"
  end

  test do
    system "#{bin}/ggh"
  end
end
