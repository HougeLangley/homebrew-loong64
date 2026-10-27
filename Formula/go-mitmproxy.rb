class Go-mitmproxy < Formula
  desc "mitmproxy implemented with golang. 用 Golang 实现的中间人攻击（Man-in-the-middle），解析、监测、篡改 HTTP/HTTP"
  homepage "https://example.org/go-mitmproxy"
  version "1.9.4"
  url "http://127.0.0.1:8080/brew/bottles/go-mitmproxy--1.9.4.loongarch64.bottle.tar.gz"
  sha256 "8846b6f6514828546e66778e00c3fc1c723efcd02e62c92ed2c09ab2d8869add"

  def install
    bin.install "go-mitmproxy"
  end

  test do
    system "#{bin}/go-mitmproxy"
  end
end
