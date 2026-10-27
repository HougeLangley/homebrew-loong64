class Amass < Formula
  desc "In-depth attack surface mapping and asset discovery"
  homepage "https://example.org/amass"
  version "5.1.3"
  url "http://127.0.0.1:8080/brew/bottles/amass--5.1.3.loongarch64.bottle.tar.gz"
  sha256 "3262e9b947ee2c891a7eb4d806a284819d3c5929f79cee4b64dcdc96e77b8158"

  def install
    bin.install "amass"
  end

  test do
    system "#{bin}/amass"
  end
end
