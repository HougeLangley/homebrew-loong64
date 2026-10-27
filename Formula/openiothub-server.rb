class Openiothub-server < Formula
  desc "Server for OpenIoTHub"
  homepage "https://example.org/openiothub-server"
  version "1.2.25"
  url "http://127.0.0.1:8080/brew/bottles/openiothub-server--1.2.25.loongarch64.bottle.tar.gz"
  sha256 "2f0e0f7bb2db7f250cba9f4edfd91372a425e083f1024759ee0f8a8ac79be58e"

  def install
    bin.install "openiothub-server"
  end

  test do
    system "#{bin}/openiothub-server"
  end
end
