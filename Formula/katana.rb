class Katana < Formula
  desc "A next-generation crawling and spidering framework."
  homepage "https://example.org/katana"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/katana--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "13b3dbd92a492f05eb0a5729bdf52c740c47435dcf56424b3ab34ea5a2054c90"

  def install
    bin.install "katana"
  end

  test do
    system "#{bin}/katana"
  end
end
