class Meshbird < Formula
  desc "Distributed private networking"
  homepage "https://example.org/meshbird"
  version "2.3"
  url "http://127.0.0.1:8080/brew/bottles/meshbird--2.3.loongarch64.bottle.tar.gz"
  sha256 "ed2ee5a6ea00d8d1550b23db383921f41a34a0887bd29b3c3fd9ff93bb34cd56"

  def install
    bin.install "meshbird"
  end

  test do
    system "#{bin}/meshbird"
  end
end
