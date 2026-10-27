class Aptly < Formula
  desc "Swiss army knife for Debian repository management"
  homepage "https://example.org/aptly"
  version "1.6.3"
  url "http://127.0.0.1:8080/brew/bottles/aptly--1.6.3.loongarch64.bottle.tar.gz"
  sha256 "c4010db766c948b0ca42c2a3c27a61471bb4b661dd3e8f67216d7dc35226ff7a"

  def install
    bin.install "aptly"
  end

  test do
    system "#{bin}/aptly"
  end
end
