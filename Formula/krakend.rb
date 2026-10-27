class Krakend < Formula
  desc "Ultra-High performance API Gateway built in Go"
  homepage "https://example.org/krakend"
  version "3.0.2"
  url "http://127.0.0.1:8080/brew/bottles/krakend--3.0.2.loongarch64.bottle.tar.gz"
  sha256 "19180766c904e615beba8eec0ab337ba5f59f3f927ef1195520ab8555c344957"

  def install
    bin.install "krakend"
  end

  test do
    system "#{bin}/krakend"
  end
end
