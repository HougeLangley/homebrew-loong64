class Tfproviderlint < Formula
  desc "Terraform Provider Lint Tool"
  homepage "https://example.org/tfproviderlint"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/tfproviderlint--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "4a3d79fdaef4a42cb68056f2c5c83e0da5c7162912aaad3270d2d70b9b39ef5e"

  def install
    bin.install "tfproviderlint"
  end

  test do
    system "#{bin}/tfproviderlint"
  end
end
