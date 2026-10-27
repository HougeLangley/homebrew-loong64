class Sniproxy < Formula
  desc "🧷 自用的简单 SNIProxy（常用于网站负载均衡、基于域名(SNI)的端口转发等"
  homepage "https://example.org/sniproxy"
  version "1.0.7"
  url "http://127.0.0.1:8080/brew/bottles/sniproxy--1.0.7.loongarch64.bottle.tar.gz"
  sha256 "537c29923bc9a2d05bb325ffdb86cfa90ad3f1aff5a1ab9a7faa31e45a895fb4"

  def install
    bin.install "sniproxy"
  end

  test do
    system "#{bin}/sniproxy"
  end
end
