class Tracetest < Formula
  desc "Build integration and end-to-end tests"
  homepage "https://example.org/tracetest"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/tracetest--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "83998f593fb2620934cbe55dc1b44e188c237c0a931dee0fc4a4666916009094"

  def install
    bin.install "tracetest"
  end

  test do
    system "#{bin}/tracetest"
  end
end
