class Sish < Formula
  desc "HTTP(S)/WS(S)/TCP Tunnels to localhost using only SSH."
  homepage "https://example.org/sish"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/sish--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "b8bdd6831d0bd64a4bfce57f72430ef4b34c0fb1fc4d367d23a019f31ea24a2d"

  def install
    bin.install "sish"
  end

  test do
    system "#{bin}/sish"
  end
end
