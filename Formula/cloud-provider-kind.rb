class Cloud-provider-kind < Formula
  desc "Cloud provider for KIND clusters"
  homepage "https://example.org/cloud-provider-kind"
  version "0.12.0"
  url "http://127.0.0.1:8080/brew/bottles/cloud-provider-kind--0.12.0.loongarch64.bottle.tar.gz"
  sha256 "c29bd1ee4572efdbdcdf360fe2b8dfc004f2e648c5e349eea6e69d60f01fcecd"

  def install
    bin.install "cloud-provider-kind"
  end

  test do
    system "#{bin}/cloud-provider-kind"
  end
end
