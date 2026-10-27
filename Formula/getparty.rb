class Getparty < Formula
  desc "Multi-part HTTP download manager"
  homepage "https://example.org/getparty"
  version "1.28.3"
  url "http://127.0.0.1:8080/brew/bottles/getparty--1.28.3.loongarch64.bottle.tar.gz"
  sha256 "4a975cb78c10a17779604c0296ffd0888800d9dc1bf4cbbdbb8af5745de226d3"

  def install
    bin.install "getparty"
  end

  test do
    system "#{bin}/getparty"
  end
end
