class Gcx < Formula
  desc "CLI for managing Grafana Cloud resources"
  homepage "https://example.org/gcx"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/gcx--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "98cd5ddb920622cfee3543fac998a5c4eb5554a11173b1d487ea19d088fa46d0"

  def install
    bin.install "gcx"
  end

  test do
    system "#{bin}/gcx"
  end
end
