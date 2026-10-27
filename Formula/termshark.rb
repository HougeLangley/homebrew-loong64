class Termshark < Formula
  desc "Terminal UI for tshark, inspired by Wireshark"
  homepage "https://example.org/termshark"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/termshark--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "6efce1ee4d7d3cfc7eafb56e78bfcea7e9c36c650cf9209c5afa50057df4fb1e"

  def install
    bin.install "termshark"
  end

  test do
    system "#{bin}/termshark"
  end
end
