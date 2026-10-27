class Ehco < Formula
  desc "Network relay tool and a typo :)"
  homepage "https://example.org/ehco"
  version "1.1.6"
  url "http://127.0.0.1:8080/brew/bottles/ehco--1.1.6.loongarch64.bottle.tar.gz"
  sha256 "b2cd4dcfa45f55589297df87d241def04b89817551d23fa998287b4b7c7ad80d"

  def install
    bin.install "ehco"
  end

  test do
    system "#{bin}/ehco"
  end
end
