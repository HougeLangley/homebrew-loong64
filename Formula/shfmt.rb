class Shfmt < Formula
  desc "Autoformat shell script source code"
  homepage "https://example.org/shfmt"
  version "3.14.1"
  url "http://127.0.0.1:8080/brew/bottles/shfmt--3.14.1.loongarch64.bottle.tar.gz"
  sha256 "c876deb0ed1c68ce059acacd27421a2559e46b37cc3167c32d65a6e6762c5243"

  def install
    bin.install "shfmt"
  end

  test do
    system "#{bin}/shfmt"
  end
end
