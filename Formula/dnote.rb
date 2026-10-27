class Dnote < Formula
  desc "A simple command line notebook"
  homepage "https://example.org/dnote"
  version "cli-v0.17.0"
  url "http://127.0.0.1:8080/brew/bottles/dnote--cli-v0.17.0.loongarch64.bottle.tar.gz"
  sha256 "dd5edc23add55781fefe54ae8ad400fdbb65031f42e2d90c7d87b1e58ebe2f0f"

  def install
    bin.install "dnote"
  end

  test do
    system "#{bin}/dnote"
  end
end
