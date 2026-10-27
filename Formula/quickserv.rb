class Quickserv < Formula
  desc "Dangerously user-friendly web server for quick prototyping and hackathons"
  homepage "https://example.org/quickserv"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/quickserv--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "85a5b5828b745d4028f65ac7a2e632433c5031e6085e99d51c516b140de83e32"

  def install
    bin.install "quickserv"
  end

  test do
    system "#{bin}/quickserv"
  end
end
