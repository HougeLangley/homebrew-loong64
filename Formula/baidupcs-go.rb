class Baidupcs-go < Formula
  desc "Terminal utility for Baidu Network Disk"
  homepage "https://example.org/baidupcs-go"
  version "4.0.2"
  url "http://127.0.0.1:8080/brew/bottles/baidupcs-go--4.0.2.loongarch64.bottle.tar.gz"
  sha256 "3ad827125a6298d985cf78c87a68b38971114eff87aa978ab7b5f19070380281"

  def install
    bin.install "baidupcs-go"
  end

  test do
    system "#{bin}/baidupcs-go"
  end
end
