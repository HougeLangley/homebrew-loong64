class Ouch < Formula
  desc "Painless compression and decompression"
  homepage "https://example.org/ouch"
  version "0.8.3"
  url "http://127.0.0.1:8080/brew/bottles/ouch--0.8.3.loongarch64.bottle.tar.gz"
  sha256 "b6a7fb7dd79867afa369a5d7d1be9f0fb2bc135e88ad163d8a49c0680765b014"

  def install
    bin.install "ouch"
  end

  test do
    system "#{bin}/ouch"
  end
end
