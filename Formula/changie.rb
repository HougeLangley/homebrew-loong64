class Changie < Formula
  desc "Automated changelog tool for preparing releases with lots of customization options"
  homepage "https://example.org/changie"
  version "1.26.0"
  url "http://127.0.0.1:8080/brew/bottles/changie--1.26.0.loongarch64.bottle.tar.gz"
  sha256 "92d574676f782dec394ac68ca1072822e3c9e0599a84d620111ec7df27d6beb3"

  def install
    bin.install "changie"
  end

  test do
    system "#{bin}/changie"
  end
end
