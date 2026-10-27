class Shortscan < Formula
  desc "An IIS short filename enumeration tool"
  homepage "https://example.org/shortscan"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/shortscan--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "b2d1aa600e9113355dce95a0c47aa5111d9d60ed1a468418a3174c5e362f1144"

  def install
    bin.install "shortscan"
  end

  test do
    system "#{bin}/shortscan"
  end
end
