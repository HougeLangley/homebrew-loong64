class Gof5 < Formula
  desc "F5 BIG-IP VPN client"
  homepage "https://example.org/gof5"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/gof5--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "632545878d4f6d77cb157d3dde91b9d943247aef07aa7857d271e1701e159c14"

  def install
    bin.install "gof5"
  end

  test do
    system "#{bin}/gof5"
  end
end
