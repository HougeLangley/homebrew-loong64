class Bettercap < Formula
  desc "The Swiss Army knife for 802.11, BLE, HID, CAN-bus, IPv4 and IPv6 networks reconnaissance "
  homepage "https://example.org/bettercap"
  version "2.41.7"
  url "http://127.0.0.1:8080/brew/bottles/bettercap--2.41.7.loongarch64.bottle.tar.gz"
  sha256 "d70d397fe0e669032e1b2acfe7d609ca8dc3e5a5d60f3655e58df79c89177159"

  def install
    bin.install "bettercap"
  end

  test do
    system "#{bin}/bettercap"
  end
end
