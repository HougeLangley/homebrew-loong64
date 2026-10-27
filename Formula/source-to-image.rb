class Source-to-image < Formula
  desc "Tool for building source and injecting into docker images"
  homepage "https://example.org/source-to-image"
  version "1.6.4"
  url "http://127.0.0.1:8080/brew/bottles/source-to-image--1.6.4.loongarch64.bottle.tar.gz"
  sha256 "1995abaeb199a231b3da523ba32aff8e533ee1e2ee352613514ecdeae4cffbea"

  def install
    bin.install "source-to-image"
  end

  test do
    system "#{bin}/source-to-image"
  end
end
