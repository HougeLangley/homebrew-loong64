class Sing-box < Formula
  desc "Universal proxy platform"
  homepage "https://example.org/sing-box"
  version "1.14.4"
  url "http://127.0.0.1:8080/brew/bottles/sing-box--1.14.4.loongarch64.bottle.tar.gz"
  sha256 "f16b3b135fe298b1b3dd9497f7f16772c3e6f0607791f125ae0a060a884bb256"

  def install
    bin.install "sing-box"
  end

  test do
    system "#{bin}/sing-box"
  end
end
