class Azurehound < Formula
  desc "Azure Data Exporter for BloodHound"
  homepage "https://example.org/azurehound"
  version "3.1.3"
  url "http://127.0.0.1:8080/brew/bottles/azurehound--3.1.3.loongarch64.bottle.tar.gz"
  sha256 "413dabbe5dc20f0d6ede948b9dd239c1765123e05d760f78e26df246038a35dd"

  def install
    bin.install "azurehound"
  end

  test do
    system "#{bin}/azurehound"
  end
end
