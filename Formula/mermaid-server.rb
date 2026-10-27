class Mermaid-server < Formula
  desc "Go implementation of a HTTP server to allow remote generation of mermaid-js diagrams witho"
  homepage "https://example.org/mermaid-server"
  version "1.0.4"
  url "http://127.0.0.1:8080/brew/bottles/mermaid-server--1.0.4.loongarch64.bottle.tar.gz"
  sha256 "ee0345e9bc5f23e92c4ae5199ca103035f93cfec290a8af5324919595e585499"

  def install
    bin.install "mermaid-server"
  end

  test do
    system "#{bin}/mermaid-server"
  end
end
