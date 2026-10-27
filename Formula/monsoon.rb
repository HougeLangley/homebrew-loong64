class Monsoon < Formula
  desc "Fast HTTP enumerator"
  homepage "https://example.org/monsoon"
  version "0.10.1"
  url "http://127.0.0.1:8080/brew/bottles/monsoon--0.10.1.loongarch64.bottle.tar.gz"
  sha256 "f9cbff3b65983e2639988db10c2921f45287d620cea54f41b07a98fbab9681ea"

  def install
    bin.install "monsoon"
  end

  test do
    system "#{bin}/monsoon"
  end
end
