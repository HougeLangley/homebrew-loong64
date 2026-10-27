class Cloud-sql-proxy < Formula
  desc "Utility for connecting securely to your Cloud SQL instances"
  homepage "https://example.org/cloud-sql-proxy"
  version "2.26.3"
  url "http://127.0.0.1:8080/brew/bottles/cloud-sql-proxy--2.26.3.loongarch64.bottle.tar.gz"
  sha256 "49cb63c5608c61b33903acc0aa5be23eeb2165c7b3d4bff17cd79ad2b414b118"

  def install
    bin.install "cloud-sql-proxy"
  end

  test do
    system "#{bin}/cloud-sql-proxy"
  end
end
