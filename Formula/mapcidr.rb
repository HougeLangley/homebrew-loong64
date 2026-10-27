class Mapcidr < Formula
  desc "Subnet/CIDR operation utility"
  homepage "https://example.org/mapcidr"
  version "1.1.97"
  url "http://127.0.0.1:8080/brew/bottles/mapcidr--1.1.97.loongarch64.bottle.tar.gz"
  sha256 "60c51b202e8f2464e781ecc1976cc594788e3059c252e14cebc9458cfef41be3"

  def install
    bin.install "mapcidr"
  end

  test do
    system "#{bin}/mapcidr"
  end
end
