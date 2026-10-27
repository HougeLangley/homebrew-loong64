class Fractal6.go < Formula
  desc "Backend for Fractale: a self-organization platform"
  homepage "https://example.org/fractal6.go"
  version "0.8.6"
  url "http://127.0.0.1:8080/brew/bottles/fractal6.go--0.8.6.loongarch64.bottle.tar.gz"
  sha256 "673d541a4ca2155ba663706e7eec70a1143c7167a0b013039eb07be34f441af8"

  def install
    bin.install "fractal6.go"
  end

  test do
    system "#{bin}/fractal6.go"
  end
end
