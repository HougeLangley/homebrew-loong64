class Signmykey < Formula
  desc "Automated SSH Certificate Authority"
  homepage "https://example.org/signmykey"
  version "0.8.9"
  url "http://127.0.0.1:8080/brew/bottles/signmykey--0.8.9.loongarch64.bottle.tar.gz"
  sha256 "b4808906d2e20635ae7aa7629a991d942ee422037fbe3622a20137f3faed47d4"

  def install
    bin.install "signmykey"
  end

  test do
    system "#{bin}/signmykey"
  end
end
