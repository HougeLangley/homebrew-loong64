class Sdk < Formula
  desc "Library for using Grafana' structures in Go programs and client for Grafana REST API."
  homepage "https://example.org/sdk"
  version "0.9"
  url "http://127.0.0.1:8080/brew/bottles/sdk--0.9.loongarch64.bottle.tar.gz"
  sha256 "124bd3a75a3dcc9f43c0572bf8234eb782c198c40ab96bd541f89c1e13dd3b92"

  def install
    bin.install "sdk"
  end

  test do
    system "#{bin}/sdk"
  end
end
