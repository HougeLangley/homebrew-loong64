class Sish < Formula
  desc "HTTP(S)/WS(S)/TCP Tunnels to localhost using only SSH."
  homepage "https://example.org/sish"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/sish--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "5eeabee7c355417f44617668312e6a4e7bb0cf44125a9942fb581fca22278542"

  def install
    bin.install "sish"
  end

  test do
    system "#{bin}/sish"
  end
end
