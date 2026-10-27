class Dnscontrol < Formula
  desc "Synchronize your DNS to multiple providers from a simple DSL"
  homepage "https://example.org/dnscontrol"
  version "5.7.1"
  url "http://127.0.0.1:8080/brew/bottles/dnscontrol--5.7.1.loongarch64.bottle.tar.gz"
  sha256 "0a8a534f2bf4971fc145146526c4448834fce539f8700586235a1c2223dbe927"

  def install
    bin.install "dnscontrol"
  end

  test do
    system "#{bin}/dnscontrol"
  end
end
