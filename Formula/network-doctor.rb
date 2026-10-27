class Network-doctor < Formula
  desc "Network troubleshooting TUI"
  homepage "https://example.org/network-doctor"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/network-doctor--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "5f9bab190de675fa401cb47915f52bcd29649363f68d72be373ee3cb3a92864c"

  def install
    bin.install "network-doctor"
  end

  test do
    system "#{bin}/network-doctor"
  end
end
