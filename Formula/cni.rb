class Cni < Formula
  desc "Container Network Interface - networking for Linux containers"
  homepage "https://example.org/cni"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/cni--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "bcfe65dc9457e99df21a892a60a90dabde676790751a84973361c0757229fc51"

  def install
    bin.install "cni"
  end

  test do
    system "#{bin}/cni"
  end
end
