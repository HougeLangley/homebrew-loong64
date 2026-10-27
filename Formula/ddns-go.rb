class Ddns-go < Formula
  desc "Simple and easy-to-use DDNS"
  homepage "https://example.org/ddns-go"
  version "6.17.7"
  url "http://127.0.0.1:8080/brew/bottles/ddns-go--6.17.7.loongarch64.bottle.tar.gz"
  sha256 "b175400e025523a92541b5cae4051bcac63f8525a68e59dabac93ce2d608b643"

  def install
    bin.install "ddns-go"
  end

  test do
    system "#{bin}/ddns-go"
  end
end
