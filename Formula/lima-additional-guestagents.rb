class Lima-additional-guestagents < Formula
  desc "Additional guest agents for Lima"
  homepage "https://example.org/lima-additional-guestagents"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/lima-additional-guestagents--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "2602eb7f8ff495ca17c8b09fe3683eba499b020d43642c2120046a77aaf74ef6"

  def install
    bin.install "lima-additional-guestagents"
  end

  test do
    system "#{bin}/lima-additional-guestagents"
  end
end
