class Httpexpect < Formula
  desc "End-to-end HTTP and REST API testing for Go."
  homepage "https://example.org/httpexpect"
  version "2.17.0"
  url "http://127.0.0.1:8080/brew/bottles/httpexpect--2.17.0.loongarch64.bottle.tar.gz"
  sha256 "eab3ed4d668acd48c335ebea46ff0f69194aa2736f31634c1d89f77cf0cbbcb0"

  def install
    bin.install "httpexpect"
  end

  test do
    system "#{bin}/httpexpect"
  end
end
