class Packetbeat < Formula
  desc "Lightweight Shipper for Network Data"
  homepage "https://example.org/packetbeat"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/packetbeat--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "4f6b3b99ab74ba04a2b224829ae2ab43ecd659345c612baf1b1abe95487e3c8d"

  def install
    bin.install "packetbeat"
  end

  test do
    system "#{bin}/packetbeat"
  end
end
