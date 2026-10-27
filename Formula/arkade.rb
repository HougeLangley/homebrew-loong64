class Arkade < Formula
  desc "Open Source Marketplace For Developer Tools"
  homepage "https://example.org/arkade"
  version "0.11.134"
  url "http://127.0.0.1:8080/brew/bottles/arkade--0.11.134.loongarch64.bottle.tar.gz"
  sha256 "88023226a4e506e3edde58ed06c1d20d469f64e1a769ea26f77a3a8da39296a4"

  def install
    bin.install "arkade"
  end

  test do
    system "#{bin}/arkade"
  end
end
