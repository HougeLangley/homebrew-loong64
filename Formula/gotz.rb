class Gotz < Formula
  desc "Displays timezones in your terminal"
  homepage "https://example.org/gotz"
  version "0.1.15"
  url "http://127.0.0.1:8080/brew/bottles/gotz--0.1.15.loongarch64.bottle.tar.gz"
  sha256 "b203ea40e0a85856e32eb61038c57657283d60d6d88fbe8b1f41d6f4fbfa9f05"

  def install
    bin.install "gotz"
  end

  test do
    system "#{bin}/gotz"
  end
end
