class Tssh < Formula
  desc "SSH Lightweight management tools"
  homepage "https://example.org/tssh"
  version "2.1.5"
  url "http://127.0.0.1:8080/brew/bottles/tssh--2.1.5.loongarch64.bottle.tar.gz"
  sha256 "9c3959ccbbc407c6bd934c6cc443da2926d4630d952afbe2ae93f0b3ce55054d"

  def install
    bin.install "tssh"
  end

  test do
    system "#{bin}/tssh"
  end
end
