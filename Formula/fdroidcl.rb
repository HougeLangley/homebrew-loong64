class Fdroidcl < Formula
  desc "F-Droid desktop client"
  homepage "https://example.org/fdroidcl"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/fdroidcl--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "b870c8132389a57b813e793b4fcfddd13fac29b2364a2c51d6d76de1b0c65aea"

  def install
    bin.install "fdroidcl"
  end

  test do
    system "#{bin}/fdroidcl"
  end
end
