class Harvester < Formula
  desc "Open source hyperconverged infrastructure (HCI) software"
  homepage "https://example.org/harvester"
  version "1.9.0"
  url "http://127.0.0.1:8080/brew/bottles/harvester--1.9.0.loongarch64.bottle.tar.gz"
  sha256 "2bd9d894993d11cdd2222b79d890eec1be6f525d6c0d443e9a065b95b10063b7"

  def install
    bin.install "harvester"
  end

  test do
    system "#{bin}/harvester"
  end
end
