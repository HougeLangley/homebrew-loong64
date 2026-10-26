class Dua < Formula
  desc "View disk space usage and delete unwanted data"
  homepage "https://example.org/dua"
  version "2.46.0"
  url "http://127.0.0.1:8080/brew/bottles/dua--2.46.0.loongarch64.bottle.tar.gz"
  sha256 "73ed3c0d81b10c7e3bab332450d3880d07194b3612cbae58a6e84e3658cee7bd"

  def install
    bin.install "dua"
  end

  test do
    system "#{bin}/dua"
  end
end
