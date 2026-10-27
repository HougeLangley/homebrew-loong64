class Abnfgen < Formula
  desc "Quickly generate random documents that match an ABFN grammar"
  homepage "https://example.org/abnfgen"
  version "0.21"
  url "http://127.0.0.1:8080/brew/bottles/abnfgen--0.21.loongarch64.bottle.tar.gz"
  sha256 "b00dbf1f887fcbc92bcadf2aad781dabd3454440308dcb0d2f0b8b8d3d9758d2"

  def install
    bin.install "abnfgen"
  end

  test do
    system "#{bin}/abnfgen"
  end
end
