class Dust < Formula
  desc "More intuitive version of du"
  homepage "https://example.org/dust"
  version "1.2.6"
  url "http://127.0.0.1:8080/brew/bottles/dust--1.2.6.loongarch64.bottle.tar.gz"
  sha256 "33cf77e6e82c8553b782a07c708f42dbfed33658696e9a2ea76e2d9f0dc7ba40"

  def install
    bin.install "dust"
  end

  test do
    system "#{bin}/dust"
  end
end
