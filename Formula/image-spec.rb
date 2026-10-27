class Image-spec < Formula
  desc "OCI Image Format"
  homepage "https://example.org/image-spec"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/image-spec--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "ff4d0e23e520d93054c8aa3990b1f2447a495da1d44233b794928562e3abf04b"

  def install
    bin.install "image-spec"
  end

  test do
    system "#{bin}/image-spec"
  end
end
