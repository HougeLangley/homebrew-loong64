class Sing-box < Formula
  desc "Universal proxy platform"
  homepage "https://example.org/sing-box"
  version "1.14.4"
  url "http://127.0.0.1:8080/brew/bottles/sing-box--1.14.4.loongarch64.bottle.tar.gz"
  sha256 "9f63f54c97ee00bf75eaf302de0bea675af3361c71bd843c3b14365894c4c82d"

  def install
    bin.install "sing-box"
  end

  test do
    system "#{bin}/sing-box"
  end
end
