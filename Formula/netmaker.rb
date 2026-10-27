class Netmaker < Formula
  desc "Netmaker makes networks with WireGuard. Netmaker automates fast, secure, and distributed v"
  homepage "https://example.org/netmaker"
  version "1.7.0"
  url "http://127.0.0.1:8080/brew/bottles/netmaker--1.7.0.loongarch64.bottle.tar.gz"
  sha256 "2f972949e0fd564553b8105ed437449637375ea5ed83373d0611087ae3fee52c"

  def install
    bin.install "netmaker"
  end

  test do
    system "#{bin}/netmaker"
  end
end
